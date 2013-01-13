require 'amd-loader'
assert = require 'assert'
Node = require '../Node'

describe 'Node', ->
  it 'should be a function', ->
    assert "function" == typeof Node, 'Node is not function'

	it 'should instantiate correct Node instance without arguments', ->
    root = new Node
    assert root instanceof Node, 'wrong Node instance'

    describe '#getParent()', ->
      a = new Node
      assert !a.getParent()
      b = new Node a
      assert a==b.getParent()

    describe '#setParent()', ->
      a = new Node
      b = new Node
      b.setParent a
      assert a==b.getParent()

    describe '#getChildren()', ->
      a = new Node(null, [(new Node),(new Node)])
      assert 2 == a.getChildren().length, 'getChildren return wrong result'

    describe '#setChildren()', ->
      a = new Node null
      a.setChildren [(new Node),(new Node)]
      assert 2 == a.getChildren().length
