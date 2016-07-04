{-# LANGUAGE DeriveDataTypeable , ExistentialQuantification
    ,ScopedTypeVariables, StandaloneDeriving, RecordWildCards, FlexibleContexts, CPP
    ,GeneralizedNewtypeDeriving #-}

module Main where

import Prelude hiding (div)
import Transient.Base
#ifdef ghcjs_HOST_OS
   hiding ( option,runCloud')
#endif
import GHCJS.HPlay.View
#ifdef ghcjs_HOST_OS
   hiding (map)
#else
   hiding (map, option,runCloud')
#endif

import  Transient.Move  hiding(teleport)
import Control.Applicative
import Control.Monad
import Data.Typeable
import Data.IORef
import Control.Concurrent (threadDelay)
import Control.Monad.IO.Class
import Data.Monoid
import Data.String

main= simpleWebApp 8081 $ local $ buttons <|> linksample

linksample= do
      r <- br ++> wlink "Hi!" (toElem "This link say Hi!")`fire` OnClick 
      rawHtml . b  $ " returns "++ r

buttons= p "Different input elements:" ++> checkButton
                                       **> br ++> br
                                       ++> radio
                                       **> br ++> br
                                       ++> select
                                       <++ br
    where
    checkButton=do
       rs <- getCheckBoxes(
                       ((setCheckBox False "Red"    <++ b "red")   `fire` OnClick)
                    <> ((setCheckBox False "Green"  <++ b "green") `fire` OnClick)
                    <> ((setCheckBox False "blue"   <++ b "blue")  `fire` OnClick))
       wraw $ fromString " returns: " <> b (show rs)

    radio= do
       r <- getRadio [fromString v ++> setRadioActive v | v <- ["red","green","blue"]]

       wraw $ fromString " returns: " <> b ( show r )

    select= do
       r <- getSelect (   setOption "red"   (fromString "red")  

                      <|> setOption "green" (fromString "green")
                      <|> setOption "blue"  (fromString "blue"))
              `fire` OnClick

       wraw $ fromString " returns: " <> b ( show r )
