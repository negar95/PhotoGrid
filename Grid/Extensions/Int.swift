//
//  Int.swift
//  Grid
//
//  Created by Negar Moshtaghi on 21/11/1400 AP.
//

import Foundation

extension Int{
    func getMegaByteFromByteValue() -> String{
        let megaRatio = pow(2, 20)
        let decimalMegaValue = Decimal(self) / megaRatio

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2

        guard let stringDecimalMegaValue = numberFormatter.string(for: decimalMegaValue) else {
            return "0"
        }

        return "\(stringDecimalMegaValue)"
    }
}
