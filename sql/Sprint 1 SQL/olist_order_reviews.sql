CREATE TABLE staging.olist_order_reviews (
    review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);