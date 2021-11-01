// To parse this JSON data, do
//
//     final response = responseFromMap(jsonString);

import 'dart:convert';

Response responseFromMap(String str) => Response.fromMap(json.decode(str));

String responseToMap(Response data) => json.encode(data.toMap());

class Response {
    Response({
      required  this.numInputs,
      required  this.numLayers,
      required  this.layers,
      required  this.errors,
    });

    int numInputs;
    int numLayers;
    List<Layer> layers;
    List<dynamic> errors;

    factory Response.fromMap(Map<String, dynamic> json) => Response(
        numInputs: json["num_inputs"],
        numLayers: json["num_layers"],
        layers: List<Layer>.from(json["layers"].map((x) => Layer.fromMap(x))),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "num_inputs": numInputs,
        "num_layers": numLayers,
        "layers": List<dynamic>.from(layers.map((x) => x.toMap())),
        "errors": List<dynamic>.from(errors.map((x) => x)),
    };
}

class Layer {
    Layer({
      required  this.numInputs,
      required  this.nodes,
      required  this.activationFunctionName,
    });

    int numInputs;
    List<Node> nodes;
    String activationFunctionName;

    factory Layer.fromMap(Map<String, dynamic> json) => Layer(
        numInputs: json["num_inputs"],
        nodes: List<Node>.from(json["nodes"].map((x) => Node.fromMap(x))),
        activationFunctionName: json["activation_function_name"],
    );

    Map<String, dynamic> toMap() => {
        "num_inputs": numInputs,
        "nodes": List<dynamic>.from(nodes.map((x) => x.toMap())),
        "activation_function_name": activationFunctionName,
    };
}

class Node {
    Node({
      required  this.numInputs,
      required  this.weights,
    });

    int numInputs;
    List<double> weights;

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        numInputs: json["num_inputs"],
        weights: List<double>.from(json["weights"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "num_inputs": numInputs,
        "weights": List<dynamic>.from(weights.map((x) => x)),
    };
}
