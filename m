Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708713C816
	for <linux-modules@vger.kernel.org>; Thu,  2 May 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656631; cv=none; b=pYJWGQMj8PHdkCXAuU+yQdNOh8uP9rmXMxSdtvHNJSHt4ZaN/WXBWSqy528EfQxAIWd8BPFZM9qZkYeBtSKToLelk+snRrDxuumgs4mJPvprtJRdqkxn8WtnPb4VSegkTaQlOFuNM9mf77unWf7YD6ODNCqwMmjhrI3dM3rcz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656631; c=relaxed/simple;
	bh=vgpTnubJXGZnOqYlf9mWu/CDROcLP2EtMNYYpsuMLEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ex0WTw3N+jgr4w7Nt2+KVVG1zM72vxJKKeMS0OZfjoHuU63y90w5Hp+h/ZMs8w9RyzrSnm+UUYF9U7z1JxtXoeNzrhrg+Azd5X5huvxTXJD3nkouvsGgXvMJInKg5EgBpDTBHIBMNryiO5GrNdrtzcMRgdOeh+fltmfiqMl0i5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaaG3v98; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaaG3v98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714656627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe2Sxs+5bqG8uFONaIHGL24PCOqziXWrRn2P/mghR50=;
	b=aaaG3v98plNUbSPBNF0DpaGsce23q6VRVu2WZd+m0FLxAVz4Y69FPL96bspTTdufI0eQV+
	VgYJTuxK0RMc0mPgA5yyQcfLTD55GSvxs1jiNd24yzSTYUWzpLj7KNcpyguSAmgPenP/qg
	pyrhzp7Q6PPRg49aIiWeSkATdOsQcOk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-pj9EIuBFNAqpHI_Yifksqg-1; Thu, 02 May 2024 09:30:25 -0400
X-MC-Unique: pj9EIuBFNAqpHI_Yifksqg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5b1a8c36932so2074280eaf.3
        for <linux-modules@vger.kernel.org>; Thu, 02 May 2024 06:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714656625; x=1715261425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe2Sxs+5bqG8uFONaIHGL24PCOqziXWrRn2P/mghR50=;
        b=O9jjL83s3v3TfsBs2diiOnX39GlQ1+jA/dbczkf31gw9eeIFsZHPRSZPrD4zk6SW0K
         g3WYqR47/7d6mOXi05cdankwFojsq+CskM5O0zgMh5qpk/AMzVcgoROEiePqVrm884AV
         HMuptyDdUjc50r2cMzaO9NJu3Ru2qCvmhsFwhnphmm41SFmU50OnzchqibQMK8npgc1v
         TWTxpTwG4tMbSi0zMqtTjkqZH1+ru/+l5mCi6pgX+ygBb0eHekxGoLYZD1DmbXLGOmiZ
         cPdAcpFgy1G+qHF28vDRNQocgOhnh/E0s6pbM/jPmr2QbvyJbV34k5B2C+EJKTEEor+H
         qlLg==
X-Forwarded-Encrypted: i=1; AJvYcCXu922KXIvl64ko6+aG7z+Cs9fkBJz5MkK6c0t4i6G/HiJ8BjNh50uooNyLBlc082W+NK0cY0cIl2vIvaryG6FRLZL+XLHEFPbZZFmGtg==
X-Gm-Message-State: AOJu0YwB+/T9+kUdP1yBjcNpgXe0uU1ZmJzuvMLMuxR5pYMoVwR2Isvx
	cibo+85orE5CIJTV5BSrVJxLRdpbJkVpeTQs44+r0ZV/w0HxKNDdyQnCn0HLh3v1XmdcmdpFmKs
	8gGtzGpsqc+F0QgMMgdwCeq+EKxYTYcTEghRrzsUYW0LtGd5nzNd9Oq+kPVNLU1o=
X-Received: by 2002:a05:6870:a9aa:b0:23c:904e:a24f with SMTP id ep42-20020a056870a9aa00b0023c904ea24fmr2363562oab.31.1714656624691;
        Thu, 02 May 2024 06:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG9aAgjibRgP9ku7O4mF+TrZ+wFxwq/MOYNQ53a8CwzLaYZYhJT1F9dWSw8d2+zptUbV2tCA==
X-Received: by 2002:a05:6870:a9aa:b0:23c:904e:a24f with SMTP id ep42-20020a056870a9aa00b0023c904ea24fmr2363541oab.31.1714656624378;
        Thu, 02 May 2024 06:30:24 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id z6-20020a05622a124600b0043781985244sm468499qtx.59.2024.05.02.06.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 06:30:23 -0700 (PDT)
Message-ID: <8da6b0eb-6e44-b533-5318-f19f6f917781@redhat.com>
Date: Thu, 2 May 2024 09:30:22 -0400
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] livepatch, module: Delete the associated module of
 disabled livepatch
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
 jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, mcgrof@kernel.org
Cc: live-patching@vger.kernel.org, linux-modules@vger.kernel.org
References: <20240407035730.20282-1-laoar.shao@gmail.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <20240407035730.20282-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/24 23:57, Yafang Shao wrote:
> In our production environment, upon loading a new atomic replace livepatch,
> we encountered an issue where the kernel module of the old livepatch
> remained, despite being replaced by the new one. The detailed steps to
> reproduce that issue can be found in patch #2.
> 
> Detecting which livepatch will be replaced by the new one from userspace is
> not reliable, necessitating the need for the operation to be performed
> within the kernel itself.
> 
> This patchset aims to address this issue by automatically deleting the
> associated module of a disabled livepatch. Since a disabled livepatch can't
> be enabled again and the kernel module becomes redundant, it is safe to
> remove it in this manner.
> 
> Changes:
> - v1->v2:
>   - Avoid using kpatch utility in the example (Joe, Petr)
>   - Fix race around changing mod->state (Joe, Petr)
>   - Don't set mod->state outside of kernel/module dir (Joe, Petr)
>   - Alter selftests accordingly (Joe)
>   - Split it into two patches (Petr, Miroslav)
>   - Don't delete module from the path klp_enable_patch() (Petr, Miroslav)
>   - Make delete_module() safe (Petr)  
> 
> Yafang Shao (2):
>   module: Add a new helper delete_module()
>   livepatch: Delete the associated module of disabled livepatch
> 
>  include/linux/module.h                        |  1 +
>  kernel/livepatch/core.c                       | 16 ++--
>  kernel/module/main.c                          | 82 +++++++++++++++----
>  .../testing/selftests/livepatch/functions.sh  |  2 +
>  .../selftests/livepatch/test-callbacks.sh     | 24 ++----
>  .../selftests/livepatch/test-ftrace.sh        |  3 +-
>  .../selftests/livepatch/test-livepatch.sh     | 11 +--
>  .../testing/selftests/livepatch/test-state.sh | 15 +---
>  .../selftests/livepatch/test-syscall.sh       |  3 +-
>  .../testing/selftests/livepatch/test-sysfs.sh |  6 +-
>  10 files changed, 95 insertions(+), 68 deletions(-)
> 

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- 
Joe

