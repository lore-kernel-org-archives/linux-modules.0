Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9466329E6C
	for <linux-modules@vger.kernel.org>; Thu,  6 Nov 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435822; cv=none; b=uUliVPHlu9vDTNPEBhM2BLpEtkCrbYyvhFr5B6v2L+yXbHwBlfFzDWNrgs2XFG0Gj3421oIsdYPKAVEd5l7QkTPK+mPFQBqrX7ubKZjWx81BiXKMlsl8Gv0kWnZhD4pPlRH/dhCKR/GsXPsWs0gvKKJypz+CTghCpVR1kMXlmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435822; c=relaxed/simple;
	bh=CmB1MWecEBBp4OgxfqCuQiSEAV5QOXrCNuLXgiG46GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRiUPMr0FalEYaKIUwW/eyglvlS+hI5W+GxWwS+ogogxp4/CRR0k8B7aJ+h0X9ysrWy1sfge0YmAXMIA/cyQJW6V9XfvgpBbJEfV29nysox3M4AFuuVORjuzyUD63nd2IAsKE4Nd3q7fi1SWoJAp7/SneN69fpFm1o2lWTUTLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htPtRi9e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMVRHxJD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htPtRi9e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMVRHxJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762435819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
	b=htPtRi9eZuXuEfXzVNHt5vLXhMzGdBv+u8NMRqvyQXXYJdG/wesn1h+kgi558ymO9WB1V4
	AeGR3ke9mluYAdK+1OYH09qauo0CkJ1pOgFH/XnPVxtMF5cmhOawMKyUsku9AyNDoCUoga
	1/E8W2bgk+aZmM8QodtadVYXWMFeuv0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-dNOya_QyPTyGESzQahXI0w-1; Thu, 06 Nov 2025 08:30:15 -0500
X-MC-Unique: dNOya_QyPTyGESzQahXI0w-1
X-Mimecast-MFC-AGG-ID: dNOya_QyPTyGESzQahXI0w_1762435814
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so846540a12.2
        for <linux-modules@vger.kernel.org>; Thu, 06 Nov 2025 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762435814; x=1763040614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
        b=AMVRHxJDX8cEqQB2dBiym2BWC6LFYm3FnOpnbN227FGDdpXELBbUdqxXobgm/QYIh7
         +anK++Up/31kNGUs34oBq8BmW50E+bnWRxduM2OZPRvEKxOOD20czuwSKeptOww1tmJO
         VtZajIH7gxfzewHApW4900bCc12YAwxkOUAOmRAlPfCskf5RqzOO2IaDgHNMyriI5fZn
         bA6yAe/vwBso8nkwg+l2gsrU5+lUCraECbnpk/Z9a+v/YuJSXk7nGRVUiMxmeTkKbWY1
         e1e+kPDt2HB5DvJWoGUZs2iV5+/lg7+hU9zWArbRi40mf/K0g6KqONg5ceswyEPbcfHj
         nPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435814; x=1763040614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
        b=QtUd0vA6RWW32+VRXONRv/RX/UNJ5gaLTuBTxew4DjwfmjIe0Jof1lNx5Ky6N28otK
         OhYwz68Ug40xEc96iPTwMLCiXFiZGhM5Vf/E8/IAg679qB0/oiiGBl8ANP85nY6ylUpC
         oZy8OpPZeb0aklDg+1U0F4Nn+M4BzY3NWrRYXZZKZ6iFX9mY/JdvE7WeVPcAYWT5QwaU
         tonZC24YnZ0izQUMe4yBa4j9UfJhAKgJ++lK0UQKiJAzTrLBufV52sDwWw1pP2dmrmrE
         rB/tEL0/YrHRAplIMRv2UVigLJVS7Ki3Q9orTbReBYHlWODCGrMa0PVjTFl059vGtHfX
         2bsw==
X-Forwarded-Encrypted: i=1; AJvYcCVebJQ7K6kM8RPfTv4i7hfHr7+v/4f6HRR1QH8MXHJxVSo9AmAqZNy+lezlionZDikT4O8o6LF2bsfZk7NV@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpkoQR5bGeynFXpA/X+kmV/CTHDo//g6ktFuvdtFTO+j3lfWB
	5pTD2sNqbN6L2qo+xxiwfSIa4SKo43mskeOwTBhKAu6vdaONjVAdWRWEnZ10GJHI6GG0nAg/1MQ
	DZyn/mdCzAvrl7W8N3RMyiu/pb8E2b60dM7bobMlxiCdKvSALwBUx2mAHgqFectsg14gj/xPg9N
	uMMsyU
X-Gm-Gg: ASbGnctlPXHj+Fx9CGdrOK+sqMi6dZCg37KFlWqRuFoOR7EcHMPXBXWfeelxRGv29WF
	YILUctJCa1injuIw3lcvQv/a+TXiQDVG1sZeVGSgxnXxuAS4UmmfWwcj8U5QS9VKWnN/O0zb6Pt
	OOQJlGiLecCIyz48DjD7UPXMBzyM+Z063X5//pkkpBL3d414o8uu5oBu9Ve2R2Wn6LfCn3PooUa
	JcoLg3emXX1r2rdjiFHF8P/tSkKMT7AhTGzhz3XfDi8BMJgbUbATGEreJ/DfiNe9uTlTuQ8+/Nk
	u+mIaESfTA05hcFAm1/UWqGpoWQH9r4RDMs4ug1ey54EsecB62zaJ8LJXhySpYmNJg==
X-Received: by 2002:a05:6a20:6a11:b0:342:1265:158f with SMTP id adf61e73a8af0-34f85f23889mr10202203637.51.1762435813484;
        Thu, 06 Nov 2025 05:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF58+7mJo3sNtAxMb3Nqi6GJVi04D/CfZ0QveWCpOETxQnk4AuJy1ge7Ljn9GwytoZbabtjJg==
X-Received: by 2002:a05:6a20:6a11:b0:342:1265:158f with SMTP id adf61e73a8af0-34f85f23889mr10202143637.51.1762435812912;
        Thu, 06 Nov 2025 05:30:12 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207227sm2527090a12.33.2025.11.06.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:30:12 -0800 (PST)
Date: Thu, 6 Nov 2025 21:29:42 +0800
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
Message-ID: <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>

On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
>On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
[...]
>
>Hi Coiby,
>
>Based on the conversation with Paul, there is no reason to remove the existing
>security_kernel_post_read_file() call.
>
>The changes are similar to the 2nd link, but a bit different.
>- Define a single enumeration named READING_MODULE_COMPRESSED.
>
>- In module/main.c add a new security_kernel_post_read_file() call immediately
>after decompressing the kernel module.  Like a previous version of this patch,
>call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRESSED
>based on MODULE_INIT_COMPRESSED_FILE.
>
>- In ima_post_read_file() defer verifying the signature when the enumeration is
>READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_module.)

Hi Mimi,

Thanks for summarizing your conversation with Paul! I can confirm Paul's
approach works
https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul

While testing the patch today, I realized there is another
issue/challenge introduced by in-kernel module decompression. IMA
appraisal is to verify the digest of compressed kernel module but
currently the passed buffer is uncompressed module. When IMA uses
uncompressed module data to calculate the digest, xattr signature
verification will fail. If we always make IMA read the original kernel
module data again to calculate the digest, does it look like a
quick-and-dirty fix? If we can assume people won't load kernel module so
often, the performance impact is negligible. Otherwise we may have to
introduce a new LSM hook so IMA can access uncompressed and original
module data one time.

>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

