Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8E193418;
	Mon, 18 Nov 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924719; cv=none; b=ooZYKMa6JjR3MgfXxsAPkFct6OufOlPWFUZvx6uQH3tQQDCV7lL7uVvSO2czwoF/jWI3Zo4eqo4wbyDLaKLjc6BWFqkOHKZPtcUTsGoC1BaxUPqcfAQ+9Qmbj8338sYsI9fk9gSQAiYp6oQvYcKHODFozTR0X0N3yKntvfnqd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924719; c=relaxed/simple;
	bh=y0KL+I4yWQYvU8GZSwrNnW4aW64mki/BNWUAW3tIfnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asLTMzcSkgJe73l56PTwpxao2Q6jW05usXLD/E8IoWjJY6V9m6EgVWq70/ClMfmVZmhUxejkMr4THgFBddPcYHtJdWNjDk6v4CbTCUf05uFIKBLvfu7MUgQOQlsmgNmkFY7r8vJtrDBl/JVe64AxFvtq/XZ3DLWM71B94Yhl5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=GYZbxqqj; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="GYZbxqqj"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id E84442FC0061;
	Mon, 18 Nov 2024 11:11:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731924714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VyH+jygpYBBLCCseYTOLHa8NhRgcFqWbrqJs95FspFE=;
	b=GYZbxqqjICQmMWfuhSyyLl+hOHiA/gaWvIv+1EW8y38lQvnEf3eXa0o6pdfWZEN1tlktO/
	fY+/c49/81rUJsPzbECBhrQdAJlNIRNYbq/lKiElNot/xAYdHDoXdmdnVwJyE5ZmL2Ns+t
	j+LK6wXUZ2aHbyh4n9JZt6sdXLq8vjQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <ac82a35e-4fe0-4f22-a371-59a546fdab18@tuxedocomputers.com>
Date: Mon, 18 Nov 2024 11:11:53 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: tux@tuxedocomputers.com, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <20241114103133.547032-6-ukleinek@kernel.org>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20241114103133.547032-6-ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
> Tuxedo licenses the modules used on their hardware under GPLv3+, to
> "keep control of the upstream pacing" – and want to re-license the code
> while upstreaming.
>
> They were asked to then at least not use MODULE_LICENSE("GPL") which
> declares compatibility to the kernel's GPLv2. They accepted the pull
> request and shortly after reverted the change and so continue to lie
> about the license.
>
> So teach the module loader that these modules are proprietary despite
> their declaration to be GPLv2 compatible "until the legal stuff is
> sorted out".

The relicensing is complete so this patch can be dropped entirely (everything is 
now GPLv2+)

Regards,

Werner Sembach

>
> Link: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> ---
>   kernel/module/main.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 878191c65efc..46badbb09d5e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2338,6 +2338,39 @@ static const char *module_license_offenders[] = {
>   
>   	/* lve claims to be GPL but upstream won't provide source */
>   	"lve",
> +
> +	/*
> +	 * Tuxedo distributes their kernel modules under GPLv3, but intentially
> +	 * lies in their MODULE_LICENSE() calls.
> +	 * See https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
> +	 */
> +	"gxtp7380",
> +	"ite_8291",
> +	"ite_8291_lb",
> +	"ite_8297",
> +	"ite_829x",
> +	"stk8321",
> +	"tuxedo_compatibility_check",
> +	"tuxedo_io",
> +	"tuxedo_nb02_nvidia_power_ctrl",
> +	"tuxedo_nb04_keyboard",
> +	"tuxedo_nb04_wmi_ab",
> +	"tuxedo_nb04_wmi_bs",
> +	"tuxedo_nb04_sensors",
> +	"tuxedo_nb04_power_profiles",
> +	"tuxedo_nb04_kbd_backlight",
> +	"tuxedo_nb05_keyboard",
> +	"tuxedo_nb05_kbd_backlight",
> +	"tuxedo_nb05_power_profiles",
> +	"tuxedo_nb05_ec",
> +	"tuxedo_nb05_sensors",
> +	"tuxedo_nb05_fan_control",
> +	"tuxi_acpi",
> +	"tuxedo_tuxi_fan_control",
> +	"clevo_wmi",
> +	"tuxedo_keyboard",
> +	"clevo_acpi",
> +	"uniwill_wmi",
>   };
>   
>   /*
