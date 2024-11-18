Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F119755B;
	Mon, 18 Nov 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924641; cv=none; b=SS1rL412DKjZk9kIn0cjTvrRoJf3DCwpeP/UETgRfLoSExQECmuUpYmcHMlfSV9HFf15SqWXfTDhgAfApIMTfF7Warjef/nkdUyfEOK+dfvEHgRXHNRGTvbX9OYIUUeUJxjhWpn2Tpy5PLkwnt6+VJ2MUgbgZLQVkNC2Yj1XsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924641; c=relaxed/simple;
	bh=AsieFpbexJKtUk8eIuykamU1K9nbRjpbMm+gXVLySTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra+CpN5Nn7552+NPjLESxmCBKr1yfYkF+a9vYpzL/02Xahew5q4bcs360gpTySlm7aKrjYVdgiYDCJyf8dsqcNxdLyvnLmeXk60G9jctDZlLqF+YwqkKKJGLaViBI//MMrR/TfgeFHxelVtV0iYM8xDGey68w7OEjZGSwgpgwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=vCf2LIna; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="vCf2LIna"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id BF6D52FC005F;
	Mon, 18 Nov 2024 11:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731924629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8qv68rG+2chYRW9td3DqO1Q1cLGkq82AFGH5/cGGXQ=;
	b=vCf2LInaIE5s7vmsMluUWoakYxpw6hwEKptOgQndAZPs/1FDfyg7lC4OPKGAIHmq20P6Pj
	GGvzNWJ+7vM3uDMgX4V+AJRjhYFk42KQAVnBF8Kp9ylk8qwTI0C58n0FCduuajMdtH6NeX
	I1Vql9LouGJwtBwPASMrzR7zwJ43IXY=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <0f663358-e5e1-452b-8280-0be90ae7e7de@tuxedocomputers.com>
Date: Mon, 18 Nov 2024 11:10:28 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
To: u.kleine-koenig@baylibre.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 samitolvanen@google.com, da.gomez@samsung.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@leemhuis.info, vv@tuxedocomputers.com, cs@tuxedo.de
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
 <20241115185253.1299264-3-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20241115185253.1299264-3-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 15.11.24 um 19:50 schrieb Werner Sembach:
> From: Uwe Kleine-König <ukleinek@kernel.org>
>
> TUXEDO has not yet relicensed a module for GPLv2+ as a reply from former
> contributers the committed code under GPLv3+ is awaited.
>
> Teach the module loader that this module is not GPLv2 compatible despite
> the declaration to be GPLv2 compatible until the relicensing is complete.

The relicensing is complete so this patch can be dropped entierly

Regards,

Werner Sembach

>
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> [Remove relicensed modules and accusatory language]
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   kernel/module/main.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 905d7b60dd709..df2549352ca8a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2029,6 +2029,14 @@ static const char *module_license_offenders[] = {
>   
>   	/* lve claims to be GPL but upstream won't provide source */
>   	"lve",
> +
> +	/*
> +	 * TUXEDO awaits 2 final answers to relicense the last module to GPLv2+
> +	 * See https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/merge_requests/21 ,
> +	 * https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/dd34594ab880ed477bb75725176c3fb9352a07eb ,
> +	 * and https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/c8893684c2f869b2a6b13f1ef1ddeb4922f2ffe3
> +	 */
> +	"clevo_acpi",
>   };
>   
>   /*
