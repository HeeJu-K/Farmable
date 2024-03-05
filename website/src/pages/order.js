import { useRouter } from 'next/router';
import Cookies from 'js-cookie';


export default function Order() {

    // const router = useRouter();
    const selectedItems = Cookies.get('selectedItems');
    const parsedItems = JSON.parse(selectedItems);

    
    Cookies.remove('selectedItems');
    return (
        <div>
            {parsedItems.map((selectedItem) => (
                <p>{selectedItem.dishName}</p>
                
            ))}
        </div>
    )
}
