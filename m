Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922071D95A1;
	Thu, 14 Nov 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581351; cv=none; b=b8e4Qxtq5bKUuvYHl5YSqDaB4w/2pdXxhNVbVQH84deCbwNSn7r1kLyWiwyysj9aSlR2fpcrkHs0pvwSGBuaedjV1LnNQotDxesotaU54AKDYrZyZJxgn7noeNNjfL2C4ULA2/+lM0lKLc8PVo6TgLJ9RuKhSNOtKek5ycXKE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581351; c=relaxed/simple;
	bh=1pVwujhlE4sgAgf8ixdm9F0aPf17G792ocRgrybwWrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf8NALznRN+Yw4rCsXNbYhaYI1Yo/7x7ECXqwO/AXy+kNVgmgjFAVpSd15SQxtLCBKV+zy09OJ05rb9/IgRmFIhXSkzaEWg0GbN+w0qKRN4HJjrG7/sRrmz4ULgetoyp59J+yrDxqh8yAemmPMEdvsdKiA4Sets7X2ogI/9oUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=P9w4vJbD; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="P9w4vJbD"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 712422FC0052;
	Thu, 14 Nov 2024 11:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731581344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBrUmFsxW544nHEIzJzrCra/Vi9YhwoYI0bndIs2Yo8=;
	b=P9w4vJbDh38Tds+6qqzUbA2Swk/e6TBPiipS40T2GnSvmprF0YMeB+cHWckWiDKiEe9t51
	ECt6nQxNMJHOHF+uF7dZoVwh9q2TKDvQrrnOEa3X4A4Nv1Vf/15jaFSsjZ80LhvFeK0Nxo
	d1EhjauYh3mB1PoY784XsF/RGWSrk4Q=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
Date: Thu, 14 Nov 2024 11:49:04 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: tux@tuxedocomputers.com, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
References: <20241114103133.547032-4-ukleinek@kernel.org>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20241114103133.547032-4-ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
> Hello,
>
> the kernel modules provided by Tuxedo on
> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
> are licensed under GPLv3 or later. This is incompatible with the
> kernel's license and so makes it impossible for distributions and other
> third parties to support these at least in pre-compiled form and so
> limits user experience and the possibilities to work on mainlining these
> drivers.
>
> This incompatibility is created on purpose to control the upstream
> process. See https://fosstodon.org/@kernellogger/113423314337991594 for
> a nice summary of the situation and some further links about the issue.
>
> Note that the pull request that fixed the MODULE_LICENSE invocations to
> stop claiming GPL(v2) compatibility was accepted and then immediately
> reverted "for the time being until the legal stuff is sorted out"
> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).

As already being implied by that commit message, this is sadly not an issue that 
can be sorted out over night.

We ended up in this situation as MODULE_LICENSE("GPL") on its own does not hint 
at GPL v2, if one is not aware of the license definition table in the documentation.

It was and is never our intention to violate neither GPL v2 nor GPL v3 and we 
are working on it.

Kind regards,

Werner Sembach

>
> Best regards
> Uwe
>
> Uwe Kleine-König (2):
>    module: Put known GPL offenders in an array
>    module: Block modules by Tuxedo from accessing GPL symbols
>
>   kernel/module/main.c | 56 +++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 47 insertions(+), 9 deletions(-)
>
> base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
