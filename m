Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1E5678
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Aizbkzh4"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78712B
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 00:23:00 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DCDD93F6AE
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698909775;
	bh=Pd7/lFtP4BYuqq3e5ONr1i/noTjwBlQpKuQjz8D374U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Aizbkzh4jNb/2LzSU+PaSBMwBqyab8eqoiUpmsB/IU82MH7QxNkkph8shV4sleMb/
	 7P4PrJwRz9ysLzeyetE7p9w59cXc+58SJjGA9UVJipMKZJzvQCnVLlbzuy84P/zsRG
	 G97PAaUy7Jdm6HRJNIuRU0dVxPEFnxf7Qp0aYi+ryzk7iFapISnmRNW7i3W4XRGo2O
	 PUX5yauGroWA9ZVpa/KU82dxPHIBTIGZP8+eIcfyvVG00O4G6n+nDV0Sz3VWcSIT3H
	 FWiA3rnCsPCBnfAvL9+p7doCfpWxKwd6dsuEBzSMR6FSrh4q9FSTz+8gXHynbgpPWR
	 MWdUAfWjpKKNg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae7663e604so38865866b.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Nov 2023 00:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698909775; x=1699514575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd7/lFtP4BYuqq3e5ONr1i/noTjwBlQpKuQjz8D374U=;
        b=fI1tTEsJpELuL2A10VDVqnrt1kh5C6iW7fdyToKHXSqa/JFluj/kMEZC6tX+8SQ6nu
         eslnhqCi7ZReF7sb1GVcCiC4Y6fWAJ+myZUeEXtFzGX9O9w4eAnxWRBu/SDS7p8nBQ0A
         ckVqGwKAq8lMsyieNGQdRG6EXulD7HhGKBgilZHUKU7iM1eH9+ePAgxnPAOAQ4uUSszE
         1R2vq24Bq/uMu5Z4lrkFtA+vXRqsECsdEKzeIns/bQYJRLNHx7H/EQG5LYsndtrXWmLb
         Qz1fe4iBarbyyb4E30/+kZ3dYRGzpWqOubfssfLedh+bU+JGji4s0u5QzUdyFWMl86BP
         rLAg==
X-Gm-Message-State: AOJu0YyIty1GQv8BJOo9fAk+QXUdTWJIUsrrEeTxJh07S+LQC2xSinBh
	AIM0DtNNnqcenBtI4dJdbMLjZFafVLBgK1K5L7Rg8jTaQAyNdXNUezlf5hLqKmXEG7gtO6NoCRB
	i6Wl//DRJxfDIjIhSZTIzwrwUXj0A3aj6etIDf7Hd1MM=
X-Received: by 2002:a17:907:2ce4:b0:9d3:ccf0:761e with SMTP id hz4-20020a1709072ce400b009d3ccf0761emr3442238ejc.49.1698909775545;
        Thu, 02 Nov 2023 00:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrcaepUPUtioNdapJVIzKQ0rujHR+g4fkf/lk1zTtPY1f2mSTPZz6aIQYCyYYCxcwy7R2PJg==
X-Received: by 2002:a17:907:2ce4:b0:9d3:ccf0:761e with SMTP id hz4-20020a1709072ce400b009d3ccf0761emr3442218ejc.49.1698909775093;
        Thu, 02 Nov 2023 00:22:55 -0700 (PDT)
Received: from localhost (host-79-33-130-95.retail.telecomitalia.it. [79.33.130.95])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090606c900b009b27d4153cfsm781396ejb.176.2023.11.02.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:22:54 -0700 (PDT)
Date: Thu, 2 Nov 2023 08:22:53 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	keescook@chromium.org, zhumao001@208suo.com, yangtiezhu@loongson.cn,
	ojeda@kernel.org
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
Message-ID: <ZUNOTRWCWNJkn66n@gpd>
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
 <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>

On Wed, Nov 01, 2023 at 09:02:51PM -1000, Linus Torvalds wrote:
> On Wed, 1 Nov 2023 at 10:13, Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > The only thing worth highligthing is that gzip moves to use vmalloc() instead of
> > kmalloc just as we had a fix for this for zstd on v6.6-rc1.
> 
> Actually, that's almost certainly entirely the wrong thing to do.
> 
> Unless you *know* that the allocation is large, you shouldn't use
> vmalloc(). And since kmalloc() has worked fine, you most definitely
> don't know that.
> 
> So we have 'kvmalloc()' *exactly* for this reason, which is a "use
> kmalloc, unless that is too small, then use vmalloc".
> 
> kmalloc() isn't just about "use physically contiguous allocations".
> It's also more memory-efficient, and a *lot* faster than vmalloc(),
> which has to play VM tricks.
> 
> So this "just switch to vmalloc()" is entirely wrong.
> 
>               Linus

I proposed that change mostlfy for consistency with the zstd case, but I
haven't experience any issue with gzip compressed modules (that seem to
require less memory, even with larger modules).

So, yes, it probably makes sense to drop this change for now and I can
send another patch to switch to kvmalloc() for all the decompress cases.

Thanks,
-Andrea
