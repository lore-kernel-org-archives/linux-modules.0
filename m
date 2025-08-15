Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B025EF98;
	Fri, 15 Aug 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285592; cv=none; b=fAfr5GR6EVYcbyVpri+vNA94Fq1C7JdkkwYnv7ElNRaEk5OT4R6flwGs3xGaTzDmQnValpnUBpli0VW9OIoRZcQbMi4++hTXnCfPOOO9GHK7O2SJS+y6g2Xm7A4gThjYlqae2C+K+tBWTijvYjP8pnKP7UBusby/fhsYYee51/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285592; c=relaxed/simple;
	bh=7W8NbGaC+WoX56kWR9hnHS7IbNR1YSbgRLv3ERYlvOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMgPhbWyjf5wLtH5k27HaHPBRo5YRZUxG+9OEGmgkLth0/hmQfrrz0K+tv9WPNOvJPLHNIypJNaMkYQ0U6/CG13bXrHdcroi09LaA5p2U9/Zvlk4srMcIFTKGZ6feyr1CBUgtxMxBeuDWBbhjOZeCM+lqIL6HeZDLARXvDxUZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCRc80jB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCRc80jB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2F1C4CEEB;
	Fri, 15 Aug 2025 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755285592;
	bh=7W8NbGaC+WoX56kWR9hnHS7IbNR1YSbgRLv3ERYlvOM=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BCRc80jBl9hTsz7GCP4DPrEisixh2a/FHpuP2zD3oTtQaDZLMq9z5ZzSNnUqbV03u
	 0PCaiS1Tl9jrdhGW2JlYpCJdcNCOYq5WxWwNUA39V952XEYuYJ2uJXdtnSyrsbz8qK
	 RTMffTkV9t8cPJjJ1RDytu6ZxadiUOugFZIW5NJs6pBbmt6SEmtYcLpQRfMkFeHBQP
	 PbZppvz45GeHpeXq1aNF1wubIh/l25g6aobySzuaJw2367fgD4/SaBPWpytzh2o6q2
	 n408CT7WnkJeDYr0g0krtkQjw7MP7CgN434ks1rqdh7Vtd0nN+XzzKz914Q++nydFZ
	 fYyDZ4cjRZ3zg==
Message-ID: <b047f0b3-303b-48f2-bce0-5b8d825f97e1@kernel.org>
Date: Fri, 15 Aug 2025 21:19:48 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2] params: Replace deprecated strcpy() with strscpy() and
 memcpy()
To: Petr Pavlu <petr.pavlu@suse.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <20250813132200.184064-2-thorsten.blum@linux.dev>
 <f60327bb-6546-4d15-8bd2-a05e85d96b4f@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <f60327bb-6546-4d15-8bd2-a05e85d96b4f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2025 07.14, Petr Pavlu wrote:
> On 8/13/25 3:21 PM, Thorsten Blum wrote:
>> strcpy() is deprecated; use strscpy() and memcpy() instead.
>>
>> In param_set_copystring(), we can safely use memcpy() because we already
>> know the length of the source string 'val' and that it is guaranteed to
>> be NUL-terminated within the first 'kps->maxlen' bytes.
>>
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> Changes in v2:
>> - Use memcpy() in param_set_copystring() as suggested by Petr Pavlu
>> - Link to v1: https://lore.kernel.org/lkml/20250810214456.2236-1-thorsten.blum@linux.dev/
>> ---
>>  kernel/params.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/params.c b/kernel/params.c
>> index b92d64161b75..b96cfd693c99 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
>> @@ -513,13 +513,14 @@ EXPORT_SYMBOL(param_array_ops);
>>  int param_set_copystring(const char *val, const struct kernel_param *kp)
>>  {
>>  	const struct kparam_string *kps = kp->str;
>> +	const size_t len = strnlen(val, kps->maxlen);
>>  
>> -	if (strnlen(val, kps->maxlen) == kps->maxlen) {
>> +	if (len == kps->maxlen) {
>>  		pr_err("%s: string doesn't fit in %u chars.\n",
>>  		       kp->name, kps->maxlen-1);
>>  		return -ENOSPC;
>>  	}
>> -	strcpy(kps->string, val);
>> +	memcpy(kps->string, val, len + 1);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(param_set_copystring);
>> @@ -841,7 +842,7 @@ static void __init param_sysfs_builtin(void)
>>  		dot = strchr(kp->name, '.');
>>  		if (!dot) {
>>  			/* This happens for core_param() */
>> -			strcpy(modname, "kernel");
>> +			strscpy(modname, "kernel");
>>  			name_len = 0;
>>  		} else {
>>  			name_len = dot - kp->name + 1;
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

