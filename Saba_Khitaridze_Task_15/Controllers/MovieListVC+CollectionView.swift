//
//  MovieListVC+CollectionView.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 14.07.22.
//

import UIKit


extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesByGenres.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell
        if let genreCell = cell {
            genreCell.genreLabel.text = "\(genreNames[indexPath.row])"
            genreCell.isSelected = indexPath.row == 0
            
            return genreCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCell {
            moviesTableView.isUserInteractionEnabled = indexPath.row == 0
            cell.isSelected = true
        }
        
        if genreNames[indexPath.row].rawValue == "All" {
            updateTableView()
        } else {
            movies = allMovies.filter({$0.genre.rawValue == genreNames[indexPath.row].rawValue && !$0.seen})
            watchedMovies = allMovies.filter({$0.genre.rawValue == genreNames[indexPath.row].rawValue && $0.seen})
            moviesTableView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCell {
            if indexPath.row != 0 {
                cell.isSelected = false
            }
        }
    }
    
    //Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
    }
}
