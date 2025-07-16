import { createElement } from '@lwc/engine-dom';
import CartItem from 'c/cartItem';

describe('c-cart-item', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should render the component with cart items', () => {
        const element = createElement('c-cart-item', {
            is: CartItem
        });

        element.cartItems = [
            { Id: '1', Name: 'Product 1', Quantity__c: 2, SellingPrice__c: 29.99, totalAvaliableUnits: 10 },
            { Id: '2', Name: 'Product 2', Quantity__c: 1, SellingPrice__c: 19.99, totalAvaliableUnits: 5 }
        ];

        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const datatable = element.shadowRoot.querySelector('lightning-datatable');
            expect(datatable.data.length).toBe(2);
        });
    });

    it('should handle row action event', () => {
        const element = createElement('c-cart-item', {
            is: CartItem
        });

        element.cartItems = [
            { Id: '1', Name: 'Product 1', Quantity__c: 2, SellingPrice__c: 29.99, totalAvaliableUnits: 10 },
            { Id: '2', Name: 'Product 2', Quantity__c: 1, SellingPrice__c: 19.99, totalAvaliableUnits: 5 }
        ];

        document.body.appendChild(element);

        const handler = jest.fn();
        element.addEventListener('remove', handler);

        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        datatable.dispatchEvent(new CustomEvent('rowaction', {
            detail: {
                action: { name: 'delete' },
                row: { Id: '1' }
            }
        }));

        return Promise.resolve().then(() => {
            expect(handler).toHaveBeenCalled();
        });
    });

    it('should handle save event with valid data', () => {
        const element = createElement('c-cart-item', {
            is: CartItem
        });

        element.cartItems = [
            { Id: '1', Name: 'Product 1', Quantity__c: 2, SellingPrice__c: 29.99, totalAvaliableUnits: 10 },
            { Id: '2', Name: 'Product 2', Quantity__c: 1, SellingPrice__c: 19.99, totalAvaliableUnits: 5 }
        ];

        document.body.appendChild(element);

        const handler = jest.fn();
        element.addEventListener('updatecart', handler);

        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        datatable.dispatchEvent(new CustomEvent('save', {
            detail: {
                draftValues: [
                    { Id: '1', Quantity__c: 3 }
                ]
            }
        }));

        return Promise.resolve().then(() => {
            expect(handler).toHaveBeenCalled();
            expect(element.cartItems[0].Quantity__c).toBe(3);
            expect(element.cartItems[0].Available_Units__c).toBe(7);
        });
    });

    it('should handle save event with invalid data', () => {
        const element = createElement('c-cart-item', {
            is: CartItem
        });

        element.cartItems = [
            { Id: '1', Name: 'Product 1', Quantity__c: 2, SellingPrice__c: 29.99, totalAvaliableUnits: 10 },
            { Id: '2', Name: 'Product 2', Quantity__c: 1, SellingPrice__c: 19.99, totalAvaliableUnits: 5 }
        ];

        document.body.appendChild(element);

        const handler = jest.fn();
        element.addEventListener('updatecart', handler);

        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        datatable.dispatchEvent(new CustomEvent('save', {
            detail: {
                draftValues: [
                    { Id: '1', Quantity__c: 'invalid' }
                ]
            }
        }));

        return Promise.resolve().then(() => {
            expect(handler).not.toHaveBeenCalled();
        });
    });

    it('should handle save event with quantity greater than available units', () => {
        const element = createElement('c-cart-item', {
            is: CartItem
        });

        element.cartItems = [
            { Id: '1', Name: 'Product 1', Quantity__c: 2, SellingPrice__c: 29.99, totalAvaliableUnits: 10 },
            { Id: '2', Name: 'Product 2', Quantity__c: 1, SellingPrice__c: 19.99, totalAvaliableUnits: 5 }
        ];

        document.body.appendChild(element);

        const handler = jest.fn();
        element.addEventListener('updatecart', handler);

        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        datatable.dispatchEvent(new CustomEvent('save', {
            detail: {
                draftValues: [
                    { Id: '1', Quantity__c: 15 }
                ]
            }
        }));

        return Promise.resolve().then(() => {
            expect(handler).not.toHaveBeenCalled();
        });
    });
});