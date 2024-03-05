import { useRouter } from 'next/router';
import Cookies from 'js-cookie';
import { PassThrough } from 'stream';


export default function Order() {

    // const router = useRouter();
    const selectedItems = Cookies.get('selectedItems');
    const parsedItems = JSON.parse(selectedItems);

    console.log("SEE PARSED", parsedItems)

    Cookies.remove('selectedItems');
    return (
        <div>
            {parsedItems.map((parsedItem) => (
                <div>
                    <p>{parsedItem.dishName}</p>
                    {parsedItem?.ingredients?.map((ingredient) =>
                    (<div>
                        <span>{ingredient?.produce?.harvestTime}</span>
                        <span>{ingredient?.produce?.originFarm}</span>
                    </div>)

                    )}
                </div>


            ))}
        </div>
    )
}
