Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F52309AA
	for <linux-modules@vger.kernel.org>; Tue,  8 Jul 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967134; cv=none; b=c7vo70kqPpxT4ZcAI5qDG0+9c9Yjqg44nxiheWrtjMHnX6CckRWpRS6tAkUeefzwOrSmVoWaQh41304Y2zoZiPIy0AdJscVwMyfiRSHqjz7zYwf+zTUMWTDapnwB2J3F9kXMcqlf+qenrfj/fbDh1LbnfQqgIy4BLVDjEQon1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967134; c=relaxed/simple;
	bh=VpT4faI2QrhfOSkR5ZLdixn7ZKU0ZQTFE8Y+uInHVCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/UYqZD7YfpTZe+JsAKOO3DiRVsQRERiOI3NQzKR5AXjf/HXgXdZLtp3vMD/IQQ9KgjMylTDgjlq4Bgg6L7E5zux40bpmGdS3BF51t59PHNdBk+tAfHRy1Rs1bQXWO0jMBJpK5o0ST3iMHNMwsqKm6OuTBO/oThueAxzunv/IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=anLQ5mlv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="anLQ5mlv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-454ac069223so25525815e9.1
        for <linux-modules@vger.kernel.org>; Tue, 08 Jul 2025 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751967130; x=1752571930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGJceIW5govnMWwv0NuUJQBgYLDuIDSURIFJwwyGYJU=;
        b=anLQ5mlvg1wN9HgBeWDld6tp9HA1BuNaafuz+c0vrSdEqkiFR+y5+t2Zvlv+YVqhMC
         rjM+vke+CqAbB5a6xNofYdPHWKBbD761gtv0oJSHSFKpuYpGAaPT57r5aX0eUUmv3aF6
         a7jdP3I86BEOXHfJ1E0gfa6yoVl9UfyDg2ZXMVoJEmsDMaKcFA7i/Mq6y3UWqeiKg/4k
         zN2/6V6hFsMcOE58rNZ90YAJEpM06noblm9zwomhYDWRqIz9TXrwKYBzZmN77Ev5SUlX
         AYigs259NdIRjzZyMy0CmT03wKiBfUubQtEvyNMhkVD4I0GdE0YEA+NSQGpXY7EC6hPK
         zM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751967130; x=1752571930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGJceIW5govnMWwv0NuUJQBgYLDuIDSURIFJwwyGYJU=;
        b=CNRJV9n72wScKB0ydSGimrjXj9E8XQpE9z25FApEiiM26URpf29wjZmE3aFqJ75BER
         aHlhes3VNdwWcDKxJHKAncwSop8USqmYeVFcQtxzFDQCffE5AUW261/6CPOpfw7zIrMH
         UFthqcQiwidbq4bMFos5RGHe0pW8+P29UC1BkJ3inePg2yPqgEePmf/cz5dBllUMBRrS
         sHIeXLBh7rBrb/VD3JrG2CaDcIsYsf9UnugwmburyBMIuJHbd+Wrr9G6U5vfz5fWQ2Dx
         PgXL8bn4icsHQTqnteKrFub5sDbGY3xbg7bCN8ZpIKjEBdNkQku05GPSAmc4Y9eERrg2
         eJlg==
X-Forwarded-Encrypted: i=1; AJvYcCVRFUNcTHaa6e4LuJA+tKDSQlQr4OtzZUc+r5LQest5v53h6b0vhH9QBILejfnlzxCiGrJAaXDQ47+AqWDX@vger.kernel.org
X-Gm-Message-State: AOJu0YwTInrLjVTaPhj2MddVucRzuF/V7QPXkl9LwcqCsu9SK90Mt5e0
	Hz239f6ZYINHtQoPEHuZPwlECC2zIvKAylO+gmtRCwvItVGTy/g0YqLbIuayMBcFMdg=
X-Gm-Gg: ASbGnctvIzRj+sIPJfK6UD2t3tDBvMdd0wkK19dQxAHjmLFxewQy42hfhKdKUxRWwmN
	GjRITa6WDNEpHSRjTKGoovi7W3pCdNhaujQ/rupWJwot9+1Wg8M59RXGKDzOKLZeap3MuSeqy1Z
	0gDdA/5gy8AOa2DIOBwZNYk56gN/yovUuq2EXIZXLfhiQdDisuelvbQy5a3pcrOkhZHitbEyKOK
	7kKDIrwSQJpB9Qh0GMOcrtI+AqgBLiDfaf+P1EPjA/iUZIgGaQ34bq0nB3UbUGkBBtcnIQUfckE
	f3lfebB3X4Oifz+/2efQUNPVbLUEzt6p6IUbcbqpYRdMRvORcp7lOJaFy/xfmaOTKA==
X-Google-Smtp-Source: AGHT+IGpfK2RCAo/edKvTlUC+d9AURbdyD484XFqxor+Ht3SNk4f42ge+bO29Nor8b5E8oXUHRj2Iw==
X-Received: by 2002:a05:6000:240c:b0:3a5:281b:9fac with SMTP id ffacd0b85a97d-3b5de11ea28mr1823078f8f.17.1751967130016;
        Tue, 08 Jul 2025 02:32:10 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225977dsm12455087f8f.73.2025.07.08.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:32:09 -0700 (PDT)
Message-ID: <9c8b2847-5017-45b8-bbc2-0ba96cc42961@suse.com>
Date: Tue, 8 Jul 2025 11:32:09 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] module: make structure definitions always visible
To: Daniel Gomez <da.gomez@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
 <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/25 9:11 PM, Daniel Gomez wrote:
> On 12/06/2025 16.53, Thomas WeiÃschuh wrote:
>> To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
>> it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
>> The code will still fully typechecked but the unreachable parts are
>> discarded by the compiler. This prevents accidental breakage when a certain
>> kconfig combination was not specifically tested by the developer.
>> This pattern is already supported to some extend by module.h defining
>> empty stub functions if CONFIG_MODULES=n.
>> However some users of module.h work on the structured defined by module.h.
>>
>> Therefore these structure definitions need to be visible, too.
> 
> We are missing here which structures are needed. + we are making more things
> visible than what we actually need.
> 
>>
>> Many structure members are still gated by specific configuration settings.
>> The assumption for those is that the code using them will be gated behind
>> the same configuration setting anyways.
> 
> I think code and kconfig need to reflect the actual dependencies. For example,
> if CONFIG_LIVEPATCH depends on CONFIG_MODULES, we need to specify that in
> Kconfig with depends on, as well as keep the code gated by these 2 configs with
> ifdef/IS_ENABLED.
> 
>>
>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> ---
>>  include/linux/module.h | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 52f7b0487a2733c56e2531a434887e56e1bf45b2..7f783e71636542b99db3dd869a9387d14992df45 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -302,17 +302,6 @@ static typeof(name) __mod_device_table__##type##__##name		\
>>  
>>  struct notifier_block;
>>  
>> -#ifdef CONFIG_MODULES
>> -
>> -extern int modules_disabled; /* for sysctl */
>> -/* Get/put a kernel symbol (calls must be symmetric) */
>> -void *__symbol_get(const char *symbol);
>> -void *__symbol_get_gpl(const char *symbol);
>> -#define symbol_get(x)	({ \
>> -	static const char __notrim[] \
>> -		__used __section(".no_trim_symbol") = __stringify(x); \
>> -	(typeof(&x))(__symbol_get(__stringify(x))); })
>> -
>>  enum module_state {
>>  	MODULE_STATE_LIVE,	/* Normal state. */
>>  	MODULE_STATE_COMING,	/* Full formed, running module_init. */
>> @@ -598,6 +587,18 @@ struct module {
>>  	struct _ddebug_info dyndbg_info;
>>  #endif
>>  } ____cacheline_aligned __randomize_layout;
>> +
>> +#ifdef CONFIG_MODULES
>> +
>> +extern int modules_disabled; /* for sysctl */
>> +/* Get/put a kernel symbol (calls must be symmetric) */
>> +void *__symbol_get(const char *symbol);
>> +void *__symbol_get_gpl(const char *symbol);
>> +#define symbol_get(x)	({ \
>> +	static const char __notrim[] \
>> +		__used __section(".no_trim_symbol") = __stringify(x); \
>> +	(typeof(&x))(__symbol_get(__stringify(x))); })
>> +
> 
> The patch exposes data structures that are not needed. + breaks the
> config dependencies.
> 
> For example, before this patch:
> 
> #ifdef CONFIG_MODULES
> 
> {...}
> 
> struct mod_tree_node {
> 
> {...}
> 
> struct module_memory {
> 	void *base;
> 	bool is_rox;
> 	unsigned int size;
> 
> #ifdef CONFIG_MODULES_TREE_LOOKUP
> 	struct mod_tree_node mtn;
> #endif
> };
> 
> {...}
> #endif /* CONFIG_MODULES */
> 
> After the patch, mod_tree_node is not needed externally. And the mtn field
> in module_memory is exposed only under MODULES_TREE_LOOKUP and not MODULES
> + MODULES_TREE_LOOKUP.
> 
> I general, I see the issues I mentioned with LIVEPATCH, mod_tree_node, macros,
> and LOOKUP.

I think the idea is that having unnecessary structures in header files
isn't particularly harmful, as they won't affect the resulting binary.
On the other hand, they can help with type checking of conditional code
as shown by patch #3.

This is different compared to "extern int modules_disabled;" and
"void *__symbol_get(const char *symbol);" which the patch correctly
still protects by '#ifdef CONFIG_MODULES'. Not hiding them could result
in successful compilation but an error only at link time.

-- 
Thanks,
Petr
