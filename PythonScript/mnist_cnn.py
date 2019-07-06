import tensorflow as tf
mnist = tf.keras.datasets.mnist

# loading data
(x_train, y_train),(x_test, y_test) = mnist.load_data()

# converting from 0-255 to 0-1
x_train, x_test = x_train / 255.0, x_test / 255.0


# building a model
model = tf.keras.models.Sequential()

# flatten first layer of neurons
model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
# addind first and second hidden layers of neurons
model.add(tf.keras.layers.Dense(128, activation = tf.nn.relu))
model.add(tf.keras.layers.Dense(128, activation = tf.nn.relu))
# adding output layer of neurons
model.add(tf.keras.layers.Dense(10, activation = tf.nn.softmax))

# compiling model
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# training model
model.fit(x_train, y_train, epochs=5)

# model results
model.evaluate(x_test, y_test)

# saving model
model.save('digit_recognition_model')

# converting to tf lite
converter = tf.lite.TFLiteConverter.from_saved_model(digit_recognition_model)
tflite_model = converter.convert()
open("converted_model.tflite", "wb").write(tflite_model)
