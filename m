Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25016289358
	for <linux-modules@vger.kernel.org>; Thu, 13 Nov 2025 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007015; cv=none; b=HkvNbJO2QtK3r6jI6Qg2Yks7m2IPoMq9H0J4KOdEpvSZbndnzegNHRr4Lg7TnXxE6L9kJHEMWqYujs/GyagXUrQxd3T/qHTr1Mfl5kK/iMWjA+3yK8h0Ipl1lRTPiLsRVPCXz9so5uZd/U6OvH4JI+P4JD4mcUQbZDOcDPgNZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007015; c=relaxed/simple;
	bh=zdLHuuMTe46EsyhV/bM1eTvKdfpTyHz80agisPFVCuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0x1lzEePxAoaVw+OXeHctVtuZMQVEcCBb3pp9Ms6hGA1jp8fLqhnMG/BFRQ3wHoE7bPJiT16Atw8octA3bMfymkgu9Au0XPhUCSQ8RK8FRKVoysygPHm4avHSKFbimLsXNcDXQ450dHH3S3sU3Bwwo1yrIuXE9E2C5Lv+y6bCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK9cali3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gskfUTpw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK9cali3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gskfUTpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763007013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZIBY6eCn23Q+siVmn68NakRPUJnSr/kT+giBlXwV0A=;
	b=UK9cali3rYxqnUnx1WKwHY5mIeLdeh/PwKomQoAkrg/iJDq9LKEKuIBH9DbR9y+pw8ANpQ
	pzPQwGrJwMICfqAV97qfuJvOhTr+1PMbdQ3xjzD140IMUtyNA/SITEvjloXUrOdSFdgm8e
	XZ1a7Bz4pD+v9AB2/IHK68PHlKqxT0o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-8P1eRjOlO9mKon7n8GxpIw-1; Wed, 12 Nov 2025 23:10:11 -0500
X-MC-Unique: 8P1eRjOlO9mKon7n8GxpIw-1
X-Mimecast-MFC-AGG-ID: 8P1eRjOlO9mKon7n8GxpIw_1763007011
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so377691a12.1
        for <linux-modules@vger.kernel.org>; Wed, 12 Nov 2025 20:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763007010; x=1763611810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZIBY6eCn23Q+siVmn68NakRPUJnSr/kT+giBlXwV0A=;
        b=gskfUTpwvpr7GgL9lhSxHuBqkbWXrWdUM4GQDLuxst7w8koBW8OSryzYjTmf3D3VgX
         tx1AYILH2dyQcKUlS5lTvFyVRrEepi67s87UDnssMK7WmLXwY4YCeEos9dCxdoJzovnE
         UhiVYX1vur4TDFJrWTtMUOQVkEB+UaggyOJw1OYC9h/9pFpMsvxAq0/rquh2xx8mZTZQ
         buTSs9i3ZYffqoRxZvzzOyfO2depQ+Fx9M5iQW32hJzb2xm/6KJ2IAWQCEg5XjHr//Ga
         OuEM4YsZlh8w2ZVBqO7BbyopQ1LyTP7IBxSIILteRXsHsxWB+fRQlDVuycwcOF2v+NCK
         PSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007010; x=1763611810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZIBY6eCn23Q+siVmn68NakRPUJnSr/kT+giBlXwV0A=;
        b=flpXlHjHJV2a9aoloOPVbGNkyAHVjLujKNretn+lNsentsJnkIpuq4m67nE18ucod5
         5bAcd+IfReYV1rEmiprV+iCD51qO0v2Ws37D5ItCp6BcGICu2IUos9qLYYSgGrM2goU2
         o44qKoIdzsxFQsuQnKjOqcPqINNeOFicM+Qa7DpGNBW0xlu+xNYv5LFwHwNgnnyv1Jnt
         F1xNqMBzJ6Zi/3tIuIJVFE7caYbOJpPu8ofghlT3XrJY7pWpOTZeNNvzgLusNoCgzHGI
         NRsV4x1j5w3kfwT//qK/ZrD9b3EHhy22Q7/3r9ErxYsnnMVoBQH7Hd8bQeHeBjgKKJ1H
         NxQA==
X-Forwarded-Encrypted: i=1; AJvYcCXS97Y7vP9XXHOACt6BqnCNDg1Oa9ekzA6CXl1MNusyWG9MCidW9jdbVPHT+VJHCjUwh+Epex9lDsOBDUr0@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVSz/uhiqyON21eE3c0/c/k4o73olCTJfzkgb42cPEfkHLufE
	SBsgUfryjMj5Zk/ZYUJA8tNYO/ezhz82c2y/RiVyHAICEGqlvYGCHLdzFSR0SvgQt+OPd26DJz/
	m/9x0NBJOQs+Og/YYS+Rm5H6lGdZ5Aar3v5pnwiohDRl1mft1yt9jon/OtA2xZGUFXjk=
X-Gm-Gg: ASbGncsmBF4ESsCpdAPPluRjrT7iD+9bWzu5GvdvTSbphMFslh9BAivjhfW2q+vUc4J
	NRvJIgghkfyP8tuU5mGxUPS2t1rTqtiXcerPjhlDMn8fEiBSR2pn75JuTAYe4Yw7dWhxToNUKjj
	sxeQF3JK0oNpnOFcgmsXQFUackF38UQlpZRfWvvjfEP5RCDTl6wi0aj7skQSiZPUvnZxptriTBz
	V/+dEIZkWVjCF8VdLuaNkCqx18OkkKlaNJKgnEeC4gZr6hiIH0lpatdJBvwTpqc6bh8s4DH57/L
	7iKZNJ3G5XQ8awfBmj2NlKaHK6L4wuAEkQGPHA3KMOIjYTN+xbJ9myPXn6RAzC0Nbw==
X-Received: by 2002:a17:903:4b04:b0:298:529b:8956 with SMTP id d9443c01a7336-298529b8bd1mr54723705ad.56.1763007010486;
        Wed, 12 Nov 2025 20:10:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWDwN+5E+tsPmc61Ky6R88DQMezRVeNlZMFO+j6cmwW//kMzz/cF3f2/ywvf8oGJ38G1y9PQ==
X-Received: by 2002:a17:903:4b04:b0:298:529b:8956 with SMTP id d9443c01a7336-298529b8bd1mr54723255ad.56.1763007009881;
        Wed, 12 Nov 2025 20:10:09 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm8193665ad.7.2025.11.12.20.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:10:09 -0800 (PST)
Date: Thu, 13 Nov 2025 12:06:02 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <42qcfcxxlmwphctzvji76hy5tycfabiiv5u6zw6lgg2p3e2jwv@fp4g2y7ecf2y>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
 <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
 <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
 <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>

On Fri, Nov 07, 2025 at 02:28:13PM -0500, Mimi Zohar wrote:
>On Thu, 2025-11-06 at 17:15 -0500, Mimi Zohar wrote:
>> On Thu, 2025-11-06 at 21:29 +0800, Coiby Xu wrote:
>> > On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
>> > > On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
>> > [...]
>> > >
>> > > Hi Coiby,
>> > >
>> > > Based on the conversation with Paul, there is no reason to remove the existing
>> > > security_kernel_post_read_file() call.
>> > >
>> > > The changes are similar to the 2nd link, but a bit different.
>> > > - Define a single enumeration named READING_MODULE_COMPRESSED.
>> > >
>> > > - In module/main.c add a new security_kernel_post_read_file() call immediately
>> > > after decompressing the kernel module.  Like a previous version of this patch,
>> > > call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRESSED
>> > > based on MODULE_INIT_COMPRESSED_FILE.
>> > >
>> > > - In ima_post_read_file() defer verifying the signature when the enumeration is
>> > > READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_module.)
>> >
>> > Hi Mimi,
>> >
>> > Thanks for summarizing your conversation with Paul! I can confirm Paul's
>> > approach works
>> > https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul
>> >
>> > While testing the patch today, I realized there is another
>> > issue/challenge introduced by in-kernel module decompression. IMA
>> > appraisal is to verify the digest of compressed kernel module but
>> > currently the passed buffer is uncompressed module. When IMA uses
>> > uncompressed module data to calculate the digest, xattr signature
>> > verification will fail. If we always make IMA read the original kernel
>> > module data again to calculate the digest, does it look like a
>> > quick-and-dirty fix? If we can assume people won't load kernel module so
>> > often, the performance impact is negligible. Otherwise we may have to
>> > introduce a new LSM hook so IMA can access uncompressed and original
>> > module data one time.
>>
>> ima_collect_measurement() stores the file hash info in the iint and uses that
>> information to verify the signature as stored in the security xattr.
>> Decompressing the kernel module shouldn't affect the xattr signature
>> verification.
>
>In the case when the compressed kernel module hasn't previously been measured or
>appraised before loading the kernel module, we need to "collect" the file data
>hash on READING_MODULE_COMPRESSED, but defer appraising/measuring it.
>
>An alternative to your suggestion of re-reading the original kernel module data
>to calculate the digest or defining a new hook, would be to define "collect" as
>a new "action" and pass the kernel_read_file_id enumeration to
>process_measurement().  IMA_COLLECTED already exists.  Only IMA_COLLECT would
>need to be defined.  The new collect "action" should be limited to
>func=MODULE_CHECK.
>
>The downside of this alternative is that it requires a new collect rule:
>collect func=MODULE_CHECK mask=MAY_READ uid=0
>appraise func=MODULE_CHECK appraise_type=imasig|modsig

Thank for suggesting an alternative! I've implemented the idea in
https://github.com/coiby/linux/tree/in_kernel_decompression_ima_collect

Note besides a new collect rule, another change is needed. Currently,
process_measurement only accepts enum ima_hooks thus it can't tell if
it's READING_MODULE_COMPRESSED so to only do collect action. So I
create a fake MODULE_COMPRESSED_CHECK func.

And for the idea of re-reading the original kernel module data, it has
been implemented in 
https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul

Both branches have applied your requested three changes including
respecting the 80 char line limit. Additionally, I made a change to the
IPE LSM because of the new READING_MODULE_COMPRESSED kernel_read_file_id
enumerate.

After comparing the two implementations, personally I prefer re-reading
the original kernel module data because the change is smaller and it's
more user-friendly. But if there are other reasons I don't know, I'll
post the patches of the new collect action approach to the mailing list.


-- 
Best regards,
Coiby

