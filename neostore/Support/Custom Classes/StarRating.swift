

import UIKit

protocol StarRatingViewDelegate: AnyObject {
    func didUpdateRating(_ rating: Int)
}

@IBDesignable
class StarRatingView: UIView {

    weak var delegate: StarRatingViewDelegate?

    private var starImageViews: [UIImageView] = []
    private let maxStars = 5

    @IBInspectable var rating: CGFloat = 0 {
        didSet {
            updateStars()
        }
    }

    @IBInspectable var starSize: CGSize = CGSize(width: 30, height: 30) {
        didSet {
            setupStars()
        }
    }

    @IBInspectable var spacing: CGFloat = 5 {
        didSet {
            setupStars()
        }
    }

    @IBInspectable var filledStarImage: UIImage? {
        didSet {
            updateStars()
        }
    }

    @IBInspectable var emptyStarImage: UIImage? {
        didSet {
            updateStars()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }

    private func setupStars() {
        starImageViews.forEach { $0.removeFromSuperview() }
        starImageViews.removeAll()

        for index in 0..<maxStars {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tag = index + 1
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageView.isUserInteractionEnabled = true

            addSubview(imageView)
            starImageViews.append(imageView)
        }

        let stackView = UIStackView(arrangedSubviews: starImageViews)
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        updateStars()
    }

    private func updateStars() {
        for (index, imageView) in starImageViews.enumerated() {
            let starValue = CGFloat(index) + 1
            if rating >= starValue {
                imageView.image = filledStarImage
            } else {
                imageView.image = emptyStarImage
            }
        }
    }

    @objc private func starTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedStar = gesture.view as? UIImageView else { return }
        rating = CGFloat(tappedStar.tag)
        updateStars()

        delegate?.didUpdateRating(Int(rating))
    }
}
