Return-Path: <SRS0=ZrDV=WE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D236C433FF
	for <linux-modules@archiver.kernel.org>; Thu,  8 Aug 2019 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3156F2171F
	for <linux-modules@archiver.kernel.org>; Thu,  8 Aug 2019 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565270703;
	bh=uLmBQhpPROBoG2c+9dw9qZ9m+9TvUAsO1qu3HlU0Xgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BFsOKD/tebd8Fq4+w1P1orQCavETDSuZVV2kfbXIyS7McTusORqWo6+VMZy3vMP9D
	 OV9wI/mUgKyyw/8FnGLiVApZOS6M1HwKZuBgabMqmcTWOtOmvWCMxCOg+aSXMHOLrc
	 kLx6NSB+Josn1e/xabvLNhktxBDd8mrBf61Ov+X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbfHHNZC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfHHNZC (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 8 Aug 2019 09:25:02 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2F42171F;
        Thu,  8 Aug 2019 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565270701;
        bh=uLmBQhpPROBoG2c+9dw9qZ9m+9TvUAsO1qu3HlU0Xgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/iK4Dsi3CRsJuYRH/lT4r9ycPqFY295yEYsfDuN4W5ex5YHIFXifz9TbYc39ntBl
         IGY9UzuXVxQo+Aki4HRf3LAVi5pMiyWnzhECG0qR1qwB9diDL0JgXP5PmUDMUH3/8P
         ByFfOM7d5bH2FZRPzBmr+vkTKvUjI4tJc5PJZyt8=
Date:   Thu, 8 Aug 2019 15:24:57 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Module compression & loadpin
Message-ID: <20190808132457.GB29211@linux-8ccs>
References: <20190731222209.GA101140@chromium.org>
 <20190802183243.GA246294@chromium.org>
 <CAKi4VA+5YBaKHoEy819MBDoCTPY9Wsu=DzXPFaibAjL91GjhzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKi4VA+5YBaKHoEy819MBDoCTPY9Wsu=DzXPFaibAjL91GjhzA@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

+++ Lucas De Marchi [06/08/19 15:53 -0700]:
>+Jessica
>
>On Sat, Aug 3, 2019 at 9:50 AM Jack Rosenthal <jrosenth@chromium.org> wrote:
>>
>> Has anyone looked into what it may take to support both module
>> compression and loadpin (ensures modules come from trusted filesystem)?
>>
>> From my understanding, this is not supported as kmod currently does the
>> decompression of modules, and loadpin prefers fload_module as it can
>> tell where the module came from. (https://crbug.com/777204)
>>
>> In a gist, I am thinking supporting this scenario would require the
>> module decompression to happen on the kernel side. Wondering if anyone
>> has looked into this before I go making a solution...
>
>That's my thought as well. In order to use finit_module() with
>compressed modules we need to teach the kernel how to open it. It
>should not be difficult since kernel already has the decompression
>libraries. This also gives us access to another
>compression/decompression algorithms - but would be nice to have a
>correspondent implementation for modinfo.
>
>I planned to do that some years ago, but never implemented it. Nobody
>that I know of is currently working on that. It would be a very
>welcome contribution.

Indeed, I don't know of anyone currently working on that. I do not
think it should be that difficult, since as Lucas already mentioned we
already have multiple decompression libraries in the kernel to extract
the compressed kernel image on boot (see: lib/decompress.c and
friends), so at first glance, I don't think it would be too hard to
extend this functionality to the module loader. I'd welcome a patchset :)

Thanks,

Jessica

