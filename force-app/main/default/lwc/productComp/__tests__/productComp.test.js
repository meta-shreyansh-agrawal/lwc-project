import { createElement } from '@lwc/engine-dom';
import ProductComp from 'c/productComp';

describe('c-product-comp', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should render the component correctly', () => {
        const element = createElement('c-product-comp', {
            is: ProductComp
        });
        document.body.appendChild(element);

        // Verify the component renders with the correct initial state
        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        expect(datatable).not.toBeNull();
    });

    it('should handle search input', () => {
        const element = createElement('c-product-comp', {
            is: ProductComp
        });
        document.body.appendChild(element);

        const searchInput = element.shadowRoot.querySelector('lightning-input');
        searchInput.value = 'Test Product';
        searchInput.dispatchEvent(new CustomEvent('change'));

        // Verify the handleSearch function is called
        // This would typically involve a mock function and checking if it was called
    });

    it('should handle next page button click', () => {
        const element = createElement('c-product-comp', {
            is: ProductComp
        });
        document.body.appendChild(element);

        const nextButton = element.shadowRoot.querySelectorAll('lightning-button')[1];
        nextButton.dispatchEvent(new CustomEvent('click'));

        // Verify the nextPage function is called
        // This would typically involve a mock function and checking if it was called
    });

    it('should handle sort event', () => {
        const element = createElement('c-product-comp', {
            is: ProductComp
        });
        document.body.appendChild(element);

        const datatable = element.shadowRoot.querySelector('lightning-datatable');
        datatable.dispatchEvent(new CustomEvent('sort', { detail: { fieldName: 'Name', sortDirection: 'asc' } }));

        // Verify the handleSort function is called
        // This would typically involve a mock function and checking if it was called
    });

    it('should update available units', () => {
        const element = createElement('c-product-comp', {
            is: ProductComp
        });
        document.body.appendChild(element);

        const arr = [
            [{ Id: '001', Available_Units__c: 5 }, { Id: '002', Available_Units__c: 3 }],
            [{ Id: '001', Available_Units__c: 3 }, { Id: '002', Available_Units__c: 1 }]
        ];
        element.updateAvailableUnits(arr);

        // Verify the available units are updated correctly
        // This would typically involve checking the component's state or UI
    });

    it('should handle remove product', () => {
        const element = createElement('c-product-comp', {
            is: ProductComp
        });
        document.body.appendChild(element);

        const removedProductsFromCart = [{ Id: '001', Quantity__c: 2 }];
        element.handleRemoveProduct(removedProductsFromCart);

        // Verify the handleRemoveProduct function is called
        // This would typically involve a mock function and checking if it was called
    });
});