select * from vendor;

select p.name 'Name', concat("$", p.price) 'Price', v.name 'Vendor' 
	from product p
		join vendor v
		on v.id = p.vendorID;