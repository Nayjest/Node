###
Node module
###
define [], ->
  "use strict"

  _linkPc = (parent, child)->
    if child._parent
      if child._parent is parent
        return
      child.detach()
    parent._children.push child
    child._parent = parent

  class Node

    ###
    @param {Node|null} parent
    @param {Array<Node>} children
    @return {Node} new instance
    ###
    constructor:(parent, children) ->
      @_children = []
      @setParent parent
      @setChildren children

    # Useful if you use node Node as mixin
    isNode: true

    ###
    @return {Array<Node>} children list
    ###
    getChildren: -> @_children

    ###
    @param {Array<Node>} children
    @return {Node} this
    ###
    setChildren: (children = [])->
      @detachChildren()
      for node in children
        @addChild node
      @

    ###
    @return {Node} this
    ###
    detachChildren: ->
      if @_children.length
        for node in @_children
          node.detach()
      @

    ###
    @param {Node} parent
    @return {Node} this
    ###
    addChild: (node) ->
      _linkPc @, node
      @

    ###
    @param {Node|null} parent
    @return {Node} this
    ###
    setParent: (parent = null) ->
      if parent
        _linkPc parent, @
      else
        @detach()
      @

    ###
    @return {Node|null} parent if exists
    ###
    getParent:()-> @_parent

    ###
    @param {Node} child
    @return {Boolean} true if child belongs to this object
    ###
    hasChild: (node) ->
      @_children.indexOf(node) isnt -1

    hasChildren: -> @_children.length isnt 0

    ###
    Get plain array of all levels node children
    @return Array[Node]
    ###
    getChildrenDeep: () ->
      res = [].concat @_children
      for node in @_children
        res = res.concat node.getAllChildrenRecursive()
      res

    ###
    Remove item from parents children list and set parent to null.
    If have no parent, do nothing.
    @return Node this
    ###
    detach: ->
      if @_parent
        @_parent._children.splice @_parent._children.indexOf @, 1
      @