import functions_framework
import sys, traceback
import json
import shortuuid

@functions_framework.http
def helloWorld(request):
	"""Responds to any HTTP request.
	Args:
		request (flask.Request): HTTP request object.
	Return:
		The response text or any set of values that can be turned into a
		Response object using
		'make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>'.
	"""
	try:
		# Generating uuid
		guid = str(shortuuid.ShortUUID().random(length=18))

		response_msg = json.dumps({
			'message': 'Hello World!',
			'guid': guid,
		})

		return response_msg, 200, {'Content-Type': 'application/json'}
	except Exception:
		exc = sys.exception()
		print(repr(traceback.format_exception(exc)))
		internal_error = open('internal_server_error.json')
		body = json.load(internal_error)
		return body, 500, {'Content-Type': 'application/json'}