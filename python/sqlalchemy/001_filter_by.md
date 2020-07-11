# SQLAlchemy ORM 高级查询之过滤, 排序

    Session = sessionmaker(bind=engine)
    session = Session()
    print(session.query(Cookie.cookie_name, Cookie.quantity).first())

    for cookie in session.query(Cookie).order_by(desc(Cookie.quantity)):
        print('{:3} - {}'.format(cookie.quantity, cookie.cookie_name))

    # query = session.query(Cookie).order_by(Cookie.quantity)[:2]
    query = session.query(Cookie).order_by(Cookie.quantity).limit(4)
    print([result.cookie_name for result in query])

    inv_count = session.query(func.sum(Cookie.quantity)).scalar()
    print(inv_count)

    rec_count = session.query(func.count(Cookie.cookie_name)).first()
    print(rec_count)

    rec_count = session.query(func.count(Cookie.cookie_name).label('inventory_count')).first()
    print(rec_count.keys())
    print(rec_count.inventory_count)

    record = session.query(Cookie).filter(Cookie.cookie_name == 'chocolate chip').first()
    print record

    record = session.query(Cookie).filter_by(cookie_name='chocolate chip').first()
    print(record)

    query = session.query(Cookie).filter(Cookie.cookie_name.like('%chocolate%'))
    for record in query:
        print(record.cookie_name)

    results = session.query(Cookie.cookie_name, 'SKU-' + Cookie.cookie_sku).all()
    for row in results:
        print(row)

    query = session.query(Cookie.cookie_name, cast((Cookie.quantity * Cookie.unit_cost),
                                                   Numeric(12, 2)).label('inv_cost'))
    for result in query:
        print('{} - {}'.format(result.cookie_name, result.inv_cost))

    query = session.query(Cookie).filter(
        Cookie.quantity > 23,
        Cookie.unit_cost < 0.40
        )
    for result in query:
        print(result.cookie_name)

    query = session.query(Cookie).filter(
        or_(
            Cookie.quantity.between(10, 50),
            Cookie.cookie_name.contains('chip')
            )
        )
    for result in query:
        print(result.cookie_name)


####  参考

    http://www.cnblogs.com/aguncn/p/6037834.html
