Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E681C8606;
	Wed, 22 Oct 2025 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161517; cv=none; b=D+JNRJLiBbHFtYgAyN7mIOX/sEVfDdp+jm/v7X/endRsavVly70gNQmKJ5ZCnO5PLQlw2v8k42Ms3Kb0BRUEngpK0tek+jxna9u40/dOl8JV1Vqj0oe6YGqsR4VU8L5ZohLRGpHJsozY6WG8RvPWYTq+assBM8krnp4q2Yoi7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161517; c=relaxed/simple;
	bh=DMCBbT9Aq24u+PasVGHAJczYG7vG6quPlA3iyJvngc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SccOTSVssQFuZiII28MQSuPsRSxW1+uqQKAJf+sYm8he48ql5HGiuIr7M+4WuvMuGayjkNwKeMlpgFy8Dbx5FW7/ZNvUL1p6itRc8pVeH0c+6bNkkz/qG2SYmfPnuEkRUFdfXhlsilCpxkSDBwwkAppb2m6ekVypT/8Blb0S87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wyKIboF8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wyKIboF8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lrrq2Cj27BdBpTnOZHqUUMrh+hMufS7NHhrHWF4hvLk=; b=wyKIboF8s6GuGVkClVVD26u6Uo
	xBtjebvWxH/I7IRBa7Pcwc4EzmipTJ/Rw/+8eaeANTbwPmwarOKUUAy/4hRswBgZXQ+Jp3cdzonGG
	dC2zPS39EExW8AbUclFMrhsxbJjAgs/9IsgXA4R2TKsWaJ/JLjwyS79JtXQkyezfGxJ6ouMQFKjbI
	hKhjL9Fr1vf5fF2MGrL/12zX+fkvs9Eoz4gWjeYDyi97X7VyhuhqdKhIPBlYfS0A5HjFTK5514S8n
	mnoud0+4cfOXLNDL8pkgiQLTwvK+VQwXDEQQp/dNvsyDtNi984+wmOvPCMfZpxsmgzhWmrwY97T3Z
	1FjFnZmQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBeYq-000000048wp-0o0S;
	Wed, 22 Oct 2025 19:31:52 +0000
Message-ID: <caf949d7-09b4-4a36-bf38-43af13e8e308@infradead.org>
Date: Wed, 22 Oct 2025 12:31:51 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] taint/module: Remove unnecessary taint_flag.module field
To: Petr Pavlu <petr.pavlu@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Petr Mladek <pmladek@suse.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251022082938.26670-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251022082938.26670-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/25 1:28 AM, Petr Pavlu wrote:
> The TAINT_RANDSTRUCT and TAINT_FWCTL flags are mistakenly set in the
> taint_flags table as per-module flags. While this can be trivially

Ah, I had just noticed these this morning.

> corrected, the issue can be avoided altogether by removing the
> taint_flag.module field.
> 
> This is possible because, since commit 7fd8329ba502 ("taint/module: Clean
> up global and module taint flags handling") in 2016, the handling of module
> taint flags has been fully generic. Specifically, module_flags_taint() can
> print all flags, and the required output buffer size is properly defined in
> terms of TAINT_FLAGS_COUNT. The actual per-module flags are always those
> added to module.taints by calls to add_taint_module().
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> The patch is based on linux-next (20251021) because I wanted to avoid
> a conflict with "taint: add reminder about updating docs and scripts" [1],
> which is currently queued in mm-nonmm-unstable.
> 
> [1] https://lore.kernel.org/all/20251015221626.1126156-1-rdunlap@infradead.org/
> 
> ---
>  include/linux/panic.h |  1 -
>  kernel/module/main.c  |  2 +-
>  kernel/panic.c        | 46 ++++++++++++++++++++-----------------------
>  3 files changed, 22 insertions(+), 27 deletions(-)
> 

-- 
~Randy
