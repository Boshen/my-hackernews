jest.dontMock '../Constants.coffee'

describe 'Constants', ->
  Constants = require '../Constants.coffee'

  it 'should define actions', ->
    expect(Constants).toEqual {
      CREATE_ITEM: 'CREATE_ITEM'
    }
