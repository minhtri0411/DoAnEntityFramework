using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sale_Cars.Helpers
{
    public class Cart
    {
        public List<CartItems>  Items {get; set;}

        public Cart()
        {
            Items = new List<CartItems>();
        }
        public bool Add(CartItems item)
        {
            CartItems existedItem = Items.Where(i => i.ProID == item.ProID).FirstOrDefault();
            
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Product pro = ctx.Products.Where(p => p.ProID == item.ProID).FirstOrDefault();

                if (existedItem != null)
                {
                    if (pro.Quantity < (existedItem.Quantity + item.Quantity))
                        {
                            return false;
                        }
                    existedItem.Quantity += item.Quantity;
                }
                else//existedItem == null
                {
                    if (pro.Quantity == 0 || pro.Quantity < item.Quantity)
                        {
                            return false;
                        }
                    Items.Add(item);
                }

                return true;
            }
        }

        public void RemoveItem(int proID)
        {
            CartItems existedItem = Items.Where(i => i.ProID == proID).FirstOrDefault();

            if (existedItem != null)
            {
               Items.Remove(existedItem);
            }
        }

        public void UpdateItem(int proID,int quantity)
        {
            CartItems existedItem = Items.Where(i => i.ProID == proID).FirstOrDefault();

            if (existedItem != null)
            {
                existedItem.Quantity = quantity;
            }
        }

        public int GetNumberOfItems()
        {
            return Items.Sum(i => i.Quantity);
        }
    }

    public class CartItems
    {
        public int ProID {get;set;}
        public int Quantity{get;set;}
    }
}