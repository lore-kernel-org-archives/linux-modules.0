Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EF2045B6;
	Mon, 28 Jul 2025 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685006; cv=none; b=fUnxjEm/cU8Aztjod1tMGBgn3yZjpfIWsWHNCXYyw6yZEdSLw8pFspcO53MO0M4KRaxCxv1cpN0GbNFakeVCWtiaeNi+5EBJtOF1gK7yeVY6ugaiQAdrP3/agx5QZtAez5DB0Z3afiH7IAr78PolJhyUOspUBz9SXpq7dNWDiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685006; c=relaxed/simple;
	bh=Bq+6sWaBzV8RyiVyipzxpknJy9Eii8ZzV1x8BKcFMrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzxEj41QEFpQ6x7NFCTTPA3tEzSPKQpylTRnk8zVmlYYPtzwPJICivleHvUf7P9ZoZ/T+lnoPTEy5110yZIMu0X9VlIwe3vfyUh1e7r6gujfSY6ymYeNQiVklMJ5T3UGb43GX7WfRaczM0s2w8352YWJ0XH7u8A8F62MaSZkP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwO2xFl/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwO2xFl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61800C4CEE7;
	Mon, 28 Jul 2025 06:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753685005;
	bh=Bq+6sWaBzV8RyiVyipzxpknJy9Eii8ZzV1x8BKcFMrI=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dwO2xFl/t4ZBBQWIV8VjTsueXD9/qrA+WhEJuuMXpk1ObBL8aKMjVW/iJE0p9ZYCK
	 3Oub45zTYfdyl5gz9PxtQVnLAcg9yERpDe3qIxxkmVFdwkYo+qiflGMMsO47gPIdv1
	 v2QrzZdfBi96qeLZAgjy8Ccz1wK7ND4Wqs0WI+eQHNwLehjm7HJIz8Noo7BxeVSShA
	 n4IzHH6Bu1tkKn3dAE2cszOMBe2q56FqxhutdoDwsWOYZuNP97lnlH1DO7W1Ads2Kx
	 O3Vdqf8IGIAMHXRD99YUolLTa1UwuhWcWAIeY/99z6siJ8uksn8rRz5+iOXdzRXyGT
	 8MNysmnWeXLzQ==
Message-ID: <6868be4b-86d8-4b62-b545-9ee1c30c0a26@kernel.org>
Date: Mon, 28 Jul 2025 08:43:22 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 3/5] module: Restore the moduleparam prefix length check
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250630143535.267745-1-petr.pavlu@suse.com>
 <20250630143535.267745-4-petr.pavlu@suse.com>
 <15f52f4c-7809-46ab-9e13-bd487f35a80c@kernel.org>
 <264b23ee-7046-4be9-8e01-d79a517e6256@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <264b23ee-7046-4be9-8e01-d79a517e6256@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2025 11.21, Petr Pavlu wrote:
> On 7/17/25 9:23 PM, Daniel Gomez wrote:
>> On 30/06/2025 16.32, Petr Pavlu wrote:
>>> The moduleparam code allows modules to provide their own definition of
>>> MODULE_PARAM_PREFIX, instead of using the default KBUILD_MODNAME ".".
>>>
>>> Commit 730b69d22525 ("module: check kernel param length at compile time,
>>> not runtime") added a check to ensure the prefix doesn't exceed
>>> MODULE_NAME_LEN, as this is what param_sysfs_builtin() expects.
>>>
>>> Later, commit 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking
>>> for sysfs perms.") removed this check, but there is no indication this was
>>> intentional.
>>>
>>> Since the check is still useful for param_sysfs_builtin() to function
>>> properly, reintroduce it in __module_param_call(), but in a modernized form
>>> using static_assert().
>>>
>>> While here, clean up the __module_param_call() comments. In particular,
>>> remove the comment "Default value instead of permissions?", which comes
>>> from commit 9774a1f54f17 ("[PATCH] Compile-time check re world-writeable
>>> module params"). This comment was related to the test variable
>>> __param_perm_check_##name, which was removed in the previously mentioned
>>> commit 58f86cc89c33.
>>>
>>> Fixes: 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking for sysfs perms.")
>>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>>> ---
>>>  include/linux/moduleparam.h | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
>>> index bfb85fd13e1f..110e9d09de24 100644
>>> --- a/include/linux/moduleparam.h
>>> +++ b/include/linux/moduleparam.h
>>> @@ -282,10 +282,9 @@ struct kparam_array
>>>  #define __moduleparam_const const
>>>  #endif
>>>  
>>> -/* This is the fundamental function for registering boot/module
>>> -   parameters. */
>>> +/* This is the fundamental function for registering boot/module parameters. */
>>>  #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
>>> -	/* Default value instead of permissions? */			\
>>> +	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
>>
>> Can you clarify if -1 to remove the dot from prefix?
>>
>> Final code 
>> 	static_assert(sizeof(""prefix) - 1 <= __MODULE_NAME_LEN);	\
>>
>> with __MODULE_NAME_LEN being:
>>
>> #define __MODULE_NAME_LEN (64 - sizeof(unsigned long))
> 
> Correct, -1 is to account for the dot at the end of the prefix.

LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> 
> I actually also wanted to assert that the prefix ends with a dot, but
> unfortunately prefix[sizeof(prefix)-2] (with prefix being a string
> literal) is not a constant expression in C.
> 

But even if that would be possible, there are some calls that do not have
a prefix with dot. For example,

#define core_param(name, var, type, perm)				\
	param_check_##type(name, &(var));				\
	__module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)

So, you'd have to handle both cases. I mean, where __module_param_call(<prefix>
is used with either MODULE_PARAM_PREFIX or an empty string "".
