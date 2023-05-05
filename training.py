from flask import Flask, request, jsonify
from langchain.chat_models import ChatOpenAI
from gpt_index import SimpleDirectoryReader, GPTListIndex, GPTSimpleVectorIndex, LLMPredictor, PromptHelper
import sys
import os
from llama_index import ServiceContext
from flask_cors import CORS

os.environ["OPENAI_API_KEY"] = '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'

app = Flask(__name__)
CORS(app)

def construct_index(directory_path):
    max_input_size = 4096
    num_outputs = 512
    max_chunk_overlap = 20
    chunk_size_limit = 600

    prompt_helper = PromptHelper(max_input_size, num_outputs, max_chunk_overlap, chunk_size_limit=chunk_size_limit)

    llm_predictor = LLMPredictor(llm=ChatOpenAI(temperature=0.7, model_name="text-davinci-003", max_tokens=num_outputs))

    documents = SimpleDirectoryReader(directory_path).load_data()

    index = GPTSimpleVectorIndex(documents, llm_predictor=llm_predictor, prompt_helper=prompt_helper)

    index.save_to_disk('index.json')
    return index


def chatbot(input_text):
    index = GPTSimpleVectorIndex.load_from_disk('index.json')
    response = index.query(input_text, response_mode="compact")
    return response.response

@app.route('/api/chatbot', methods=['POST'])
def api_chatbot_post():
    data = request.get_json()
    input_text = data['input_text']
    response = chatbot(input_text)
    return jsonify({'response': response})

@app.route('/api/chatbot', methods=['GET'])
def api_chatbot_get():
    input_text = request.args.get('input_text')
    response = chatbot(input_text)
    return jsonify({'response': response})

if __name__ == '__main__':
    index = construct_index("docs")
    app.run()
