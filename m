Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from sessmg22.ericsson.net ([193.180.251.58]:55974 "EHLO
        sessmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeEOId1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 15 May 2018 04:33:27 -0400
From: Jakov Simunic <jakov.simunic@ericsson.com>
To: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: kmod-25 bootstrap typo
Date: Tue, 15 May 2018 08:33:24 +0000
Message-ID: <HE1PR0702MB380494D3270EE7E7626C844898930@HE1PR0702MB3804.eurprd07.prod.outlook.com>
References: <HE1PR0702MB3804B2EA7AE44D23D39C946698930@HE1PR0702MB3804.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR0702MB3804B2EA7AE44D23D39C946698930@HE1PR0702MB3804.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hello,
I've noticed a typo in the kmod bootstrap, line 63:
=A0=A0=A0=A0=A0=A0=A0echo "$topdir/configure CFLAGS=3D"-g -O2" $args $hacka=
rgs"
should be:=20
=A0=A0=A0=A0=A0=A0=A0=A0echo "$topdir/configure CFLAGS=3D'-g -O2' $args $ha=
ckargs"
--
Lijep pozdrav / Best regards
Jakov =A9imuni=E6

