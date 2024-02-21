Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A72E632
	for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708488586; cv=none; b=hRKeUxtC+AjQt78eo5K3hFAos8lhqQlb+nMK3/axfSUoceoDV9IQtmZgYwdIPdesoZPudjr/TSodutkar1yGxI8z4c6SDXzk1yc2fbZUJi0QwnGjOgZJeBpkktDX9oUv1pedPMgMtYwL3sQ/4x2fM6vP6xCZPZWsW66VdV8+7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708488586; c=relaxed/simple;
	bh=BoyCv2XA0C+7+JVVbWVZj+xrfGVaW1aWdR2j51+n5oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W01WBNUZb51+Jy3BSdquZQC9Np9tichQomNSUJT0Njh1VJo5MdPqoxgcW7cKsti4tH5h8iUrPhScHpdkREVjAJb4bLMhvnler8uV9viJoL0vydp1HgKpj4ZzypqxmgTVul6KTDA05xK3104jLfW7vDcFMMEm4R1eIwv8kG9dYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGhXZc6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGhXZc6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708488583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsQAEkKxZb0aZZCrLYFKwxoDfNw0XHFkzbzp2yj/GkI=;
	b=FGhXZc6BfIpXEPWeibBfxgkpS5RbvYfL545+YuqXpfXU7Rrv0LobX+gX9DVU16VeglXTSg
	hT3Ii+OcSWsGToVClEMVwOf4QALKiL+4eWh+g9lRBl12DE/k/s2ccaxZAc0qY1FR8DTj8G
	iM6F7ySTrjK1J4Xvm6iKX88E4siufd4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-bzppdJAzMnycAHyYGzoTDQ-1; Tue, 20 Feb 2024 23:09:42 -0500
X-MC-Unique: bzppdJAzMnycAHyYGzoTDQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78783a27ce8so31048885a.0
        for <linux-modules@vger.kernel.org>; Tue, 20 Feb 2024 20:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708488582; x=1709093382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsQAEkKxZb0aZZCrLYFKwxoDfNw0XHFkzbzp2yj/GkI=;
        b=WdoTm3YB3EO8dIELAKISaAmc4Lasf4bfqoEDwDHYCcjKWVVHL1ey9l8b+JO9dZvmSC
         8nts9ug6zgyTGhFqQVG8nG5MsvCdxv9dnVymD+uTU5MI2lxYT8W6XSkIG9ybKsjJjp+E
         v04dRipF29z1Hv3+RqTLkBZdNk4OdfcaBPvZnOvPR59k5/zElCCItakyCSgi07hNf+ro
         1FwXh0Yx1KieTEcF+2IsILVd1eIs9A4Be6t6QBGWGv+CklfpKAk8ulsT5Ddi097VRQIQ
         S7Q4YwPGDA/h+a8e2LEFtnb7DCJx69wUr3NGmy9kryloFSfow+cQtAbkGZZkBbxQ7M3W
         CsSA==
X-Forwarded-Encrypted: i=1; AJvYcCV9epf4MKkCqDfGw6da3POcl3PzO1fXjMcV6aGWh3N5UlZe5E91dVx3dYZe0M5NR3FjyCsK4Q6ESRtjGYi21UYi2zcdddksnaD8UN0ZwA==
X-Gm-Message-State: AOJu0Yy/t5FgqioPUnXub0v4wrkPInbtXvSUqcNLsw1+sb0FyWgOW9IK
	vDeZIjY+D58whExauUHlxlBECo+DG37lbYr+omCmQtJI0Z1kR4kQ9/VQ8oftRusSz39daZcb9ar
	ht1Ul80RZJj5OI6f7q2Dsc16nQGL0fYw2husaxVAjA5J+z+9U8rk0TgSyWDKaiVU=
X-Received: by 2002:ae9:e909:0:b0:787:2be6:f572 with SMTP id x9-20020ae9e909000000b007872be6f572mr18916160qkf.44.1708488581877;
        Tue, 20 Feb 2024 20:09:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5y9sT0LbGkPWM3P5wTe+4FBnoWsvYcHd8UtO9gZCCHpP2FiZzrnexj0maTEh9uzunTOHKag==
X-Received: by 2002:ae9:e909:0:b0:787:2be6:f572 with SMTP id x9-20020ae9e909000000b007872be6f572mr18916145qkf.44.1708488581624;
        Tue, 20 Feb 2024 20:09:41 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id z17-20020a05620a101100b00787375c5b64sm3967768qkj.17.2024.02.20.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 20:09:41 -0800 (PST)
Date: Tue, 20 Feb 2024 23:09:40 -0500
From: Eric Chanudet <echanude@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Changbin Du <changbin.du@huawei.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyi Su <suxiaoyi@huawei.com>
Subject: Re: [PATCH v3] modules: wait do_free_init correctly
Message-ID: <5bq77rkoutmjzv2fuw2jjsmqxfzsv2wiyz3swvpgs7hsbyxtpx@pgczoajxjvuy>
References: <20240217081810.4155871-1-changbin.du@huawei.com>
 <20240218132153.d93675d0d241f021565a08b6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218132153.d93675d0d241f021565a08b6@linux-foundation.org>

On Sun, Feb 18, 2024 at 01:21:53PM -0800, Andrew Morton wrote:
> On Sat, 17 Feb 2024 16:18:10 +0800 Changbin Du <changbin.du@huawei.com> wrote:
> > The synchronization here is just to ensure the module init's been freed
> > before doing W+X checking. But the commit 1a7b7d922081 ("modules: Use
> > vmalloc special flag") moves do_free_init() into a global workqueue
> > instead of call_rcu(). So now rcu_barrier() can not ensure that do_free_init
> > has completed. We should wait it via flush_work().
> > 
> > Without this fix, we still could encounter false positive reports in
> > W+X checking, and the rcu synchronization is unnecessary which can
> > introduce significant delay.
> > 
> > Eric Chanudet reports that the rcu_barrier introduces ~0.1s delay on a
> > PREEMPT_RT kernel.
> >   [    0.291444] Freeing unused kernel memory: 5568K
> >   [    0.402442] Run /sbin/init as init process
> > 
> > With this fix, the above delay can be eliminated.
> 
> Thanks, I'll queue this as a delta, to be folded into the base patch
> prior to upstreaming.
> 
> I added a Tested-by: Eric, if that's OK by him?

Absolutely, I should have put it in my initial reply.
Adding here as confirmation:
Tested-by: Eric Chanudet <echanude@redhat.com>

Thanks,

-- 
Eric Chanudet

