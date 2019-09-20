# Handwritten Digit Recognition
An iOS App that recognizes handwritten digits using Swift and TensorFlow Lite. TesnorFlow NN was trained on [MNIST](http://yann.lecun.com/exdb/mnist/) Dataset with [Keras](https://keras.io/). The app has two trained NN: [baseline (97.4% accuracy)](https://github.com/sevakon/handwritten-digits-recognition/blob/master/PythonScript/mnist_baseline_model.py) (FCNN) and [advanced (99.5% accuracy)](https://github.com/sevakon/handwritten-digits-recognition/blob/master/PythonScript/mnist_advanced_model.py) (CNN) models.

## Demo
<img src="https://github.com/sevakon/handwritten-digits-recognition/blob/master/demo.gif" width="360" height="640">

## About Keras

Keras is a minimalist, highly modular neural networks library, written in Python and capable of running on top of either TensorFlow or Theano. It was developed with a focus on enabling fast experimentation. Being able to go from idea to result with the least possible delay is key to doing good research.

Use Keras if you need a deep learning library that:

allows for easy and fast prototyping (through total modularity, minimalism, and extensibility).
supports both convolutional networks and recurrent networks, as well as combinations of the two.
supports arbitrary connectivity schemes (including multi-input and multi-output training).
runs seamlessly on CPU and GPU.
Read the documentation [Keras.io](http://keras.io/)

Keras is compatible with: Python 2.7-3.5.
