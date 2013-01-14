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

  ###
  Class for organizing objects hierarchy (tree)
  Limitations: 
  * object can belongs only to one parent
  * all elements of hierarchy must be instances of Node class
  ###
  class Node

    ###
    Creates node
    @param {Node|null} parent
    @param {Array<Node>|null} children
    @return {Node} new instance
    ###
    constructor:(parent, children) ->
      @_children = []
      @setParent parent
      @setChildren children

    # Useful if you use node Node as mixin
    isNode: true

    ###
    Returns list of object children
    @return {Array<Node>} children list
    ###
    getChildren: -> @_children

    ###
    Detaches all  children and links object to new children array
    @param {Array<Node>|null} children
    @return {Node} this
    ###
    setChildren: (children = [])->
      @detachChildren()
      for node in children
        @addChild node
      @

    ###
    Removes all children from object
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
    Returns parent object if exists
    @return {Node|null} parent if exists
    ###
    getParent:()-> @_parent

    ###
    Returns list of parents
    @return {Array<Node>}
    ###
    getParents: ->
      parent = null
      res = []
      while parent = @getParent()
        res.push parent
      res

    ###
    Checks that object has specified child node
    @param {Node} child
    @return {Boolean} true if child belongs to this object
    ###
    hasChild: (node) ->
      @_children.indexOf(node) isnt -1

    ###
    Checks that object has children    
    @return {Boolean} true if object has any children
    ###
    hasChildren: -> @_children.length isnt 0

    ###
    Get plain array of all levels node children
    @return {Array<Node>}
    ###
    getChildrenDeep: () ->
      res = @_children.slice 0
      for node in @_children
        res = res.concat node.getAllChildrenRecursive()
      res

    ###
    Remove item from parents children list and set parent to null.
    If have no parent, do nothing.
    @return {Node} this
    ###
    detach: ->
      if @_parent
        @_parent._children.splice @_parent._children.indexOf @, 1
      @
