RestructuredPreview = require '../lib/restructured-preview'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "RestructuredPreview", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('restructured-preview')

  describe "when the restructured-preview:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.restructured-preview')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'restructured-preview:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.restructured-preview')).toExist()

        restructuredPreviewElement = workspaceElement.querySelector('.restructured-preview')
        expect(restructuredPreviewElement).toExist()

        restructuredPreviewPanel = atom.workspace.panelForItem(restructuredPreviewElement)
        expect(restructuredPreviewPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'restructured-preview:toggle'
        expect(restructuredPreviewPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.restructured-preview')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'restructured-preview:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        restructuredPreviewElement = workspaceElement.querySelector('.restructured-preview')
        expect(restructuredPreviewElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'restructured-preview:toggle'
        expect(restructuredPreviewElement).not.toBeVisible()
