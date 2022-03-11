Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F53CC433EF
	for <linux-modules@archiver.kernel.org>; Fri, 11 Mar 2022 16:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiCKQVA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiCKQU7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Mar 2022 11:20:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAD1CD7E6
        for <linux-modules@vger.kernel.org>; Fri, 11 Mar 2022 08:19:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j26so13727377wrb.1
        for <linux-modules@vger.kernel.org>; Fri, 11 Mar 2022 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n703PiMdH28y8+lrGIdVHry6FOQRwEpTeriwZQDN8lM=;
        b=PBCyV8agNbQ33tQiq+MU01pdv/2vyhWeps1vj+oMWSpaY+Zwj4DisvvIAifV/4MKkJ
         NJ2NIBqIcthufAjjBSAeYhRmy+1mHARJQ8aZqbWnNvCRoL4UAflr3y1DocBlD91MJpAe
         Ot8dEQ7Jg+VPHwQ94EYE8EMQuvTkn8Num0Si2DZNitP/kB1VYOWCOw+maZ5xO+bCv2OR
         oTDtsRF9w3pGkAX+BS7kAWEf+Ei4pPB9XUtoUQOaPzvMdqzCJo3wSXykhgbzOT9jg4WH
         FQzIwIV0gDHgmhL9jkhixEULdkLx2iUHvGgDAEB92XoGUYzFdZl+ONQD11aT5yfzdPjV
         lUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n703PiMdH28y8+lrGIdVHry6FOQRwEpTeriwZQDN8lM=;
        b=zGcWrHT3roBEk1RxDee3msADC3rS8mwCS4Ka3UM8YGjuRHhhujhWCqMy/9XZtjeTAC
         aQDKLCnSu+q7yQfq2Stnsc0BHWWxZeyuX91/IiQI6wo378/GYEvLgLc1gKTGseHAdhYM
         pe+D9AWR8UQnOs0wjMNAM2Rg3Kxa+aGz9MmxQXTxN2Wn6vK0vZ+WsxVB9LpYaJra/TGO
         jsrukd0J/FdI53/lIQWz/OpzJGR3wUgaj08H88MSrXQVQ08U3wl9ScXqUWuNiG8Rif2L
         VKiFZNFZKbzIcuGaF3Jb7ACDDIII3vjKw1FVVG7IAqe7YSVhd0XfVF7EnqCcMUc/M0ru
         uTTg==
X-Gm-Message-State: AOAM530RCvWuwD4Usy+f8c+g8Fff1P+5mEUNttYMENZ4yVZfuqD+0BBg
        9XjS3LvmE9/An1FXOtZIs0GQHA==
X-Google-Smtp-Source: ABdhPJwzTa35YepRUOfGsy0vO6pw8vrnH3Sck1bav/ru9whktgrIUK1FL634X/kgm+zL5GC5H501tw==
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id j73-20020adf914f000000b001edbb92d0ccmr7998579wrj.297.1647015594869;
        Fri, 11 Mar 2022 08:19:54 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm7527872wmb.37.2022.03.11.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:19:54 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:19:52 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        hch@infradead.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <20220311161952.thugdrwd6junr7ib@maple.lan>
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
 <20220309120640.uumh46n2l37jaddf@maple.lan>
 <YiporeSIrkFg/YS8@bombadil.infradead.org>
 <20220311154723.ezo3wvgg4puu2zk7@maple.lan>
 <20220311160153.3k2avq24mpjyrdpy@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311160153.3k2avq24mpjyrdpy@ava.usersys.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 11, 2022 at 04:01:53PM +0000, Aaron Tomlin wrote:
> On Fri 2022-03-11 15:47 +0000, Daniel Thompson wrote:
> > On the whole it doesn't really matter much... but landing the
> > independent parts via the normal route for kgdb code reduces what I
> > have to remember acking.
> 
> Hi Daniel,
> 
> Any thoughts on this [1]? Unfortunately, the wrong In-Reply-To was
> specified. So sorry about that. I will send another iteration of the series
> so that it'll be easier for Luis to apply to mcgrof/modules-testing or
> mcgrof/modules-next but after we have more feedback.
> 
> [1]: https://lore.kernel.org/lkml/20220310102625.3441888-2-atomlin@redhat.com/

As above. I would rather not have to remember acking the header
changes as well... but it's not like the sky is going to fall in.


Daniel.
