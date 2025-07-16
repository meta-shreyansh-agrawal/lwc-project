import { createElement } from '@lwc/engine-dom';
import OrderHistory from 'c/orderHistory';

describe('c-order-history', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should render the component in new mode', () => {
        // Arrange
        const element = createElement('c-order-history', {
            is: OrderHistory
        });
        element.mode = 'new';
        element.objectApiName = 'Product2';
        element.fields = ['Name', 'Description'];
        element.recordId = '001';

        // Act
        document.body.appendChild(element);

        // Assert
        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        expect(datatable).not.toBeNull();

        const newButton = element.shadowRoot.querySelector('.slds-m-top_medium lightning-button');
        expect(newButton).not.toBeNull();
    });

    it('should render the component in edit mode', () => {
        // Arrange
        const element = createElement('c-order-history', {
            is: OrderHistory
        });
        element.mode = 'edit';
        element.objectApiName = 'Product2';
        element.fields = ['Name', 'Description'];
        element.recordId = '001';

        // Act
        document.body.appendChild(element);

        // Assert
        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        expect(datatable).not.toBeNull();

        const saveButton = element.shadowRoot.querySelector('.slds-m-top_medium lightning-button');
        expect(saveButton).not.toBeNull();
    });

});