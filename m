Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED9C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 28 Jun 2022 07:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiF1HrR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiF1HrQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Jun 2022 03:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FBEC393
        for <linux-modules@vger.kernel.org>; Tue, 28 Jun 2022 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656402433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhwYJTHCpA5f1vgUVZ/tbiw7F2pML5jzftZeJbrY+xY=;
        b=LmWdJ7nQp9B+5Fz0JCf/QvbKLgwiPw0FriFsYBLjUof38jT75VnzlO9cX/1f8wknD6jiE3
        7Jq+fTVD3vK7U4NLZTLOgUZhQBTP9NRbOPb6ReJwYVUQ5R84qJARd3Y4KUz4mxV486bt7e
        jQ6xxvEiRXhNti6XRHwOe1Zu96tWoFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-O3pgTF8yPsWobOzFSOtAOQ-1; Tue, 28 Jun 2022 03:47:11 -0400
X-MC-Unique: O3pgTF8yPsWobOzFSOtAOQ-1
Received: by mail-wr1-f70.google.com with SMTP id s1-20020a5d69c1000000b0021b9f3abfebso1565679wrw.2
        for <linux-modules@vger.kernel.org>; Tue, 28 Jun 2022 00:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vhwYJTHCpA5f1vgUVZ/tbiw7F2pML5jzftZeJbrY+xY=;
        b=DKgQzSrOzBiME0wj2lqJ6Nm3tKhiJ9r0T10Kbu65E2uSLsZMFnnp+0/Kaw3XaTlA/E
         bcJZh5mMrhLBItkBgwprndeH53vVxfmD8+6pIfkF7FVKnamkMyicZl9HXz17qMtYFNOn
         AQ0DKFN7y3IwyF9KdJh6WyRcdR7lo7BpF7wRLi6UWs/N0VGldNFVNxQvSgd78UMBz+3f
         iwnUpikXYxhqRFC321iCVyLI4XnhEsz/yCiifZ75AE7j34O7Ih2Pi/Y8pZz1DDAlJI9s
         5zLzERRINI/gnNgzjs8qNbBMpDvZQ7UOKpnJaExskAujqqNthmzwgs6sgOi2eb/PLRb2
         lJgA==
X-Gm-Message-State: AJIora/KNahKhxatjsen1A01UJSOeixwQVaAScp6fdTkR5ZACchyC54I
        ASa5ciwFlJc1lRbtZHm2jnhDpbzPwKl1J8cYwjzdUtnD0GfnBUQ88wVxL/q5i6McOFTr7M/0rrw
        GA+YVfbzDtHLoCRCPZ4onyrpe
X-Received: by 2002:a05:600c:4f13:b0:39d:b6c5:ce4e with SMTP id l19-20020a05600c4f1300b0039db6c5ce4emr25402395wmq.34.1656402429977;
        Tue, 28 Jun 2022 00:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtS3T9UbI6Ib3KtZ+peaUDKLlP6cSEmfzlOgUCOkeKGlpETh+pHg15t7TzPLRS39uNiiA5oA==
X-Received: by 2002:a05:600c:4f13:b0:39d:b6c5:ce4e with SMTP id l19-20020a05600c4f1300b0039db6c5ce4emr25402380wmq.34.1656402429815;
        Tue, 28 Jun 2022 00:47:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm13057958wrr.3.2022.06.28.00.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:47:08 -0700 (PDT)
Date:   Tue, 28 Jun 2022 08:47:08 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-06-28 05:54 +0000, Christophe Leroy wrote:
> > -	/* Store the name of the last unloaded module for diagnostic purposes */
> >   	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
> > +	strcat(last_unloaded_module, module_flags(mod, buf, false));
> 
> You replace a bounded string copy by an unbounded strict contat.
> 
> Should you use strlcat() instead ?

Hi Christophe,

Why? If I understand correctly, both the destination and source string are
NULL-terminated (see module_flags()). So, strcat() should be sufficient.


Kind regards,

-- 
Aaron Tomlin

