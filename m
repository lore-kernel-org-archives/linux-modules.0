Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E70C433EF
	for <linux-modules@archiver.kernel.org>; Sun,  1 May 2022 13:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiEAN0h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 1 May 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiEAN0g (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 1 May 2022 09:26:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E9B643ED3
        for <linux-modules@vger.kernel.org>; Sun,  1 May 2022 06:23:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-bb2nzyNUNPyo2ky-b2_4Hw-1; Sun, 01 May 2022 14:23:07 +0100
X-MC-Unique: bb2nzyNUNPyo2ky-b2_4Hw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Sun, 1 May 2022 14:23:06 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Sun, 1 May 2022 14:23:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mauro Carvalho Chehab' <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jaroslav Kysela <perex@perex.cz>,
        "Kai Vehmanen" <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "mauro.chehab@linux.intel.com" <mauro.chehab@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v2 1/2] module: update dependencies at try_module_get()
Thread-Topic: [PATCH v2 1/2] module: update dependencies at try_module_get()
Thread-Index: AQHYXJeYYtni3pRwP0OIc2wg6VHamK0KAauw
Date:   Sun, 1 May 2022 13:23:06 +0000
Message-ID: <1e88a3d4df43460c91f049762b9f4630@AcuMS.aculab.com>
References: <cover.1651314499.git.mchehab@kernel.org>
        <3c7547d551558c9da02038dda45992f91b1f5141.1651314499.git.mchehab@kernel.org>
        <Ym0l6yeTWCCAeww8@kroah.com> <20220430143814.7184bd93@sal.lan>
In-Reply-To: <20220430143814.7184bd93@sal.lan>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Mauro Carvalho Chehab
> Sent: 30 April 2022 14:38
> 
> Em Sat, 30 Apr 2022 14:04:59 +0200
> Greg KH <gregkh@linuxfoundation.org> escreveu:
> 
> > On Sat, Apr 30, 2022 at 11:30:58AM +0100, Mauro Carvalho Chehab wrote:
> 
> > Did you run checkpatch on this?  Please do :)
> >
> > > +
> > > +	if (mod == this)
> > > +		return 0;
> >
> > How can this happen?
> > When people mistakenly call try_module_get(THIS_MODULE)?
> 
> Yes. There are lots of place where this is happening:
> 
> 	$ git grep try_module_get\(THIS_MODULE|wc -l
> 	82
> 
> > We should
> > throw up a big warning when that happens anyway as that's always wrong.
> >
> > But that's a different issue from this change, sorry for the noise.
> 
> It sounds very weird to use try_module_get(THIS_MODULE).
> 
> We could add a WARN_ON() there - or something similar - but I would do it
> on a separate patch.

You could add a compile-time check.
But a run-time one seems unnecessary.
Clearly try_module_get(THIS_MODULE) usually succeeds.

I think I can invent a case where it can fail:
The module count must be zero, and a module unload in progress.
The thread doing the unload is blocked somewhere.
Another thread makes a callback into the module for some request
that (for instance) would need to create a kernel thread.
It tries to get a reference for the thread.
So try_module_get(THIS_MODULE) is the right call - and will fail here.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

