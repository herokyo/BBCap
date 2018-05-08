//
//  CurrencyVolumeViewModel.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CurrencyVolumeViewModel {

    let volumeType: DetailViewModel.VolumeType?

    var title: String? {
        return volumeType?.title
    }

    var currency: String? {
        return volumeType?.currency
    }

    init(volumeType: DetailViewModel.VolumeType? = nil) {
        self.volumeType = volumeType
    }
}
