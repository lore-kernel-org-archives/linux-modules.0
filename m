Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FC19CD1B;
	Mon, 11 Nov 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351236; cv=none; b=hPq+hqOsNvTcv6CP0tr59wp2I7J+P0XLLMhIwON2o+Ig+tkXWb6AaXVdbYXYxM6WfYyn+GLVt9hGxQbQyXCAotsLcxBQTupl0XL2yKUuMy7RVNmgnF30uGklt4wykpJ2ZxR+0b9k9OinUPTm4eu+90d6M8XiLxY7sP5TErythzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351236; c=relaxed/simple;
	bh=z5Ib76vyYe0BpY23WC3IVBifpL+ItBJOpSqR1nCIaIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5sMk1pNw8c6BSyqWr8fQeAPtELzwcgqCh5BF4Rvyybw74uT94JGc3PJ2teuKQIX8rue71Mzlt91ti10krtUyh/1lQUNr0OJD0qLUvnBzsoeBQYq+inQCO3No1ljs0aw0e6269OUeQv3dYrnYNgC2ugTa166MiduCqun8RgvcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XnJbs66gJz9sSZ;
	Mon, 11 Nov 2024 19:53:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TyAyAoVco0MG; Mon, 11 Nov 2024 19:53:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XnJbs4tpgz9sSY;
	Mon, 11 Nov 2024 19:53:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 851398B764;
	Mon, 11 Nov 2024 19:53:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id HD31GV42XuDC; Mon, 11 Nov 2024 19:53:45 +0100 (CET)
Received: from [192.168.233.59] (unknown [192.168.233.59])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B6C18B763;
	Mon, 11 Nov 2024 19:53:45 +0100 (CET)
Message-ID: <b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
Date: Mon, 11 Nov 2024 19:53:44 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
 <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
 <D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/11/2024 à 23:17, Daniel Gomez a écrit :
> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>> Once module init has succeded it is too late to cancel loading.
>> If setting ro_after_init data section to read-only fails, all we
>> can do is to inform the user through a warning.
>>
>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20230915082126.4187913-1-ruanjinjie%40huawei.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C26b5ca7363e54210439b08dd010c4865%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638667874457200373%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ZeJ%2F3%2B2Nx%2FBf%2FWLFEkhxKlDhZk8LNkz0fs%2Fg2xMcOjY%3D&reserved=0
>> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   kernel/module/main.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 2de4ad7af335..1bf4b0db291b 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
>>   #endif
>>   	ret = module_enable_rodata_ro_after_init(mod);
>>   	if (ret)
>> -		goto fail_mutex_unlock;
>> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
>> +			mod->name, __func__, ret);
>> +
>>   	mod_tree_remove_init(mod);
>>   	module_arch_freeing_init(mod);
>>   	for_class_mod_mem_type(type, init) {
>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
>>   
>>   	return 0;
> 
> I think it would make sense to propagate the error. But that would
> require changing modprobe.c. What kind of error can we expect when this
> happens?

AFAIK, on powerpc it fails with EINVAL when
- The area is a vmalloc or module area and is a hugepage area
- The area is not vmalloc or io register and MMU is not powerpc radix MMU

Otherwise it propagates the error from apply_to_existing_page_range(). 
IIUC it will return EINVAL when it hits a leaf PTE in upper directories.

On other architectures it can be different, I know some architecture try 
to split the pages when they hit hugepages and that can fail.


But I believe if it works the first time it should work next time as well.

> 
>>   
>> -fail_mutex_unlock:
>> -	mutex_unlock(&module_mutex);
>>   fail_free_freeinit:
>>   	kfree(freeinit);
>>   fail:
> 
