//
//  MoviesCell.swift
//  AvengersMovies
//
//  Created by Geovanni Josue Chavez on 3/3/24.
//

import UIKit
import AlamofireImage

class MoviesCell: UITableViewCell {
    
    var cellContent: UIView = {
        let cellContent = UIView()
        cellContent.layer.cornerRadius = 14
        cellContent.layer.masksToBounds = true
        cellContent.clipsToBounds = true
        cellContent.backgroundColor = .dark
        cellContent.translatesAutoresizingMaskIntoConstraints = false
        return cellContent
    }()
    
    lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 14
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .green
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ghostWhite
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ghostWhite
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ghostWhite
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.text = "Release:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gold
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(genreLabel)
        bottomStack.addArrangedSubview(directorLabel)
        bottomStack.addArrangedSubview(yearLabel)
        
        cellContent.addSubview(posterImage)
        cellContent.addSubview(mainStack)
        cellContent.addSubview(bottomStack)
        contentView.addSubview(cellContent)
        
        NSLayoutConstraint.activate([
            cellContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContent.heightAnchor.constraint(equalToConstant: 100),
            cellContent.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cellContent.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: cellContent.topAnchor),
            posterImage.leftAnchor.constraint(equalTo: cellContent.leftAnchor),
            posterImage.widthAnchor.constraint(equalToConstant: 175),
            posterImage.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStack.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 12),
            mainStack.rightAnchor.constraint(equalTo: cellContent.rightAnchor),
            mainStack.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 12),
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 12),
            bottomStack.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 12),
            bottomStack.rightAnchor.constraint(equalTo: cellContent.rightAnchor),
            bottomStack.bottomAnchor.constraint(lessThanOrEqualTo: cellContent.bottomAnchor, constant: -6),
        ])
        
        
    }
    
        
    func set(item: Movie) {
        let posterPath = "\(Constants.APIs.posterImageUrl)\(item.posterPath ?? "")"
        guard let posterUrl = URL(string: posterPath) else { return }
        posterImage.af.setImage(withURL: posterUrl)
        titleLabel.text = item.title
        genreLabel.text = "Vote average: \(String(format: "⭑ %.1f", item.voteAverage ?? 0))"
        guard let year = item.releaseDate?.prefix(4) else { return }
        yearLabel.text = "\(year)"

    }

}
