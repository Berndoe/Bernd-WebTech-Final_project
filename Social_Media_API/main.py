import os.path
from datetime import datetime

import firebase_admin
import json

import functions_framework
from firebase_admin import firestore, credentials
from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin

cred = credentials.Certificate('key.json')
firebase_admin.initialize_app(cred)

app = Flask(__name__)
CORS(app)
database = firestore.client()


@cross_origin()
@functions_framework.http
def main(request):
    if "users" in request.path:
        if request.method == "GET":
            path = os.path.split(request.path)[-1]
            return get_profile(path)
        elif request.method == "POST":
            return create_profile()
        elif request.method == "PATCH":
            path = os.path.split(request.path)[-1]
            return update_profile(path)
        elif request.method == "DELETE":
            path = os.path.split(request.path)[-1]
            return delete_profile(path)
    if "posts" in request.path:
        if request.method == "POST":
            return create_post()
        if request.method == "GET":
            return get_posts()


# This function creates a user profile
@app.route('/users', methods=['POST'])
def create_profile():
    user_records = request.get_json()
    query = database.collection('users').where('student_id', '==', user_records['student_id']).get()

    if len(query) > 0:
        return jsonify({'error': 'User already exists'}), 400

    # adding user to the database
    database.collection('users').document(user_records['student_id']).set(user_records)

    return jsonify({'message': 'User created successfully!'}), 201


# This function retrieves a user profile details
@app.route('/users/<string:user_id>', methods=['GET'])
def get_profile(user_id):
    user_record = database.collection('users').document(user_id)
    data = user_record.get()
    user_data = data.to_dict()
    if user_data:
        return jsonify(user_data), 200
    else:
        return jsonify({'error': 'The user cannot be found'}), 404


# This function updates a user profile
@app.route('/users/<string:user_id>', methods=['PATCH'])
def update_profile(user_id):
    record = json.loads(request.data)
    user_info = database.collection('users').document(user_id)

    if not user_info.get().exists:
        return jsonify({'error': 'The user doesn\'t exist'}), 404

    user_info.update(record)

    return jsonify({"Success": f"User profile with ID {user_id} has been updated"}), 200


# This function deletes a user profile
@app.route('/users', methods=['DELETE'])
def delete_profile():
    record = json.loads(request.data)
    user_id = record['student_id']

    # Retrieving user record from Firestore
    user_ref = database.collection('users').document(user_id)
    user_doc = user_ref.get()

    if user_doc.exists:
        user_ref.delete()

        return jsonify(''), 204

    else:
        return jsonify({'error': 'The data cannot be found'}), 404


# This function creates a post on the feed page
@app.route('/posts', methods=['POST'])
def create_post():
    sender = ""
    post_record = json.loads(request.data)
    if request.data:
        new_document_reference = database.collection('posts').document()
        time_posted = datetime.now().strftime("%m/%d/%Y %H:%M:%S")
        post_record["Posted at"] = time_posted
        new_document_reference.set(post_record)

        list_of_users = database.collection('users').stream()
        for user in list_of_users:
            user_record = user.to_dict()

            if user_record['email'] == post_record['email']:
                sender = user_record['name']
                continue
            send_email(user_record['email'], sender)

        return jsonify({'Success': 'Content has been posted'}), 201
    else:
        return jsonify({'error': 'No data was provided'}), 400


# This function gets all the posts in the database
@app.route('/posts', methods=['GET'])
def get_posts():
    post_record = database.collection('posts').stream()
    dictionary_of_posts = {}
    for post in post_record:
        dict_converter = post.to_dict()
        dictionary_of_posts[dict_converter['Posted at']] = dict_converter
    return jsonify(dictionary_of_posts)


# This function sends an email all other users when a user makes a post
def send_email(user_email, sender):
    email_collection = database.collection('notifications').document()
    print(sender)

    email = {
        "to": user_email,
        "message": {
            "subject": "New post alert!",
            "html": sender + " just made a post.Check it out!!!",
        }
    }
    email_collection.set(email)


if __name__ == '__main__':
    app.run(debug=True)
