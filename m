Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238811DC996
	for <linux-modules@vger.kernel.org>; Tue, 10 Dec 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827781; cv=none; b=icOfLtIljLQQyRUX5wgmAZyaRM1ukG1wsE7n4xELS9hX96bs8NCu6d9K2cWjPWYWeVr7iQDwuAZpr9hAJZlpHHpXUiiYjPzywzoWRarZRrYy0FS4zGZ7thOusNfLLaPsHdBauB3Kpl6y3DtHNDRO+R1NYRXCaAYsf/cxL/Xh6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827781; c=relaxed/simple;
	bh=DTd+Ro0ThaSGt/1eg/2h9LYMuTXo+hEettqlRh/EFik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=Ft9s9ui6+WPXMjABMcyk7hE/PmQCm3Q3+qLhXEYRArZEpp4B/D5H0chjqOcGj0eOpr+Im6FdIjusCCVB61+mqUaP2gx0uSxWeFxo3MHLs9nKBGT1Uawy78ETg/XhHAozCXqrNEPnFSJu+KypXPDdjiZZJ6P+zQlHGOJ8yhsVQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s5D+isdf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s5D+isdf"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241210104935euoutp02366b0bccef701367ca9ee49aedb10663~Pyyzg-G2n3123131231euoutp02B
	for <linux-modules@vger.kernel.org>; Tue, 10 Dec 2024 10:49:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241210104935euoutp02366b0bccef701367ca9ee49aedb10663~Pyyzg-G2n3123131231euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733827775;
	bh=Ymesi6DNzhimTixN6xcdkcyjh/qDgQMHPVKz8a1icd0=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=s5D+isdfR29Op87LZHl73q2XTb+K8dZgd3VSMAmpt7M6KUSYQePZ60rhMy+KUsmxM
	 gUWc8sY0fq3NYb/Z5+c3e8QBDo6h7JQUM3t+UnE9m2+9v761t8yXwjEzSraK1R+gRb
	 e+4kHrXp6rBXxsBLa/AvbMFzY+xXqocUjGpEUDh8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241210104934eucas1p2e2cc4792bd21b64a84652995dd84043d~PyyzTY7gC2956229562eucas1p2t;
	Tue, 10 Dec 2024 10:49:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.80.20821.EBC18576; Tue, 10
	Dec 2024 10:49:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241210104934eucas1p19459af12d0e83f45f9183eb1ab287757~PyyzCeZKp0220702207eucas1p1v;
	Tue, 10 Dec 2024 10:49:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210104934eusmtrp1b1a7bdbc63253d828114fbbd0c1a5c86~PyyzB9Ux-1050810508eusmtrp1E;
	Tue, 10 Dec 2024 10:49:34 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-2e-67581cbe9b84
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.32.19654.EBC18576; Tue, 10
	Dec 2024 10:49:34 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241210104934eusmtip182e30a9877935effa3a48006cb1aca9b~Pyyy2743A0566905669eusmtip1c;
	Tue, 10 Dec 2024 10:49:34 +0000 (GMT)
Received: from [106.110.32.87] (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 10 Dec 2024 10:49:33 +0000
Message-ID: <95871917-9747-40d4-8305-51bc5d75cf82@samsung.com>
Date: Tue, 10 Dec 2024 11:49:32 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
Content-Language: en-GB
To: Petr Pavlu <petr.pavlu@suse.com>
CC: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain
	<mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook
	<kees@kernel.org>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
From: Daniel Gomez <da.gomez@samsung.com>
In-Reply-To: <cee55e3b-9028-4f56-8ac6-9895ca383334@suse.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87r7ZCLSDabfNrG4M+k5u8W6t+dZ
	LS7vmsNm0TD7O6vFjQlPGS2WfnnHbLF0xVtWi82bpjI7cHh8vXmOyWPBplKPTas62TzenTvH
	7rF+y1UWj8+b5ALYorhsUlJzMstSi/TtErgyZr9cwFhw06ei/+Rv5gbGJzZdjJwcEgImEuf/
	PGbpYuTiEBJYwSgx49YyRgjnC6PE73MwzmdGiY9Ne9lgWn6/2sEMkVjOKHHz8wQ2uKpp35cy
	g1QJCexklLh/wQfE5hWwk7h/7xk7iM0ioCqxYeZdJoi4oMTJmU9YQGxRAXmJ+7dmgNUIC+RK
	tF17BhZnFhCXaPqykrWLkYNDREBF4tIjR5BdzALdTBI7Dy8Gq2cT0JTYd3ITmM0pYCOx5NkO
	dpB6ZgErieknPCHGyEs0b53NDPGAosSMiStZIOxaiVNbbjGBzJQQmMwp8WDvbXaIhIvEh6fb
	mSBsYYlXx7dAxWUkTk/ugWpOl1iybhaUXSCx5/YssDslBKwl+s7kQIQdJe5+3gwV5pO48VYQ
	4hw+iUnbpjNPYFSdhRQQs5A8PAvhgVlIHljAyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/
	dxMjMCmd/nf80w7Gua8+6h1iZOJgPMQowcGsJMLL4R2aLsSbklhZlVqUH19UmpNafIhRmoNF
	SZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cAks99g3U1Pw+Se7ilzVrO2ViwsZ894vGFn7P4N
	/nu8nntVWfzgX7js6OrF2XUzYqdEVFttMdbNUd4wc+oTY789pSUx88StOx+rXlh4P/Rx5Zqc
	NpaAN0kO7O8Xu3rlz3c8kup7O9Z1dmfYZKmY9A9+/itX3Zgb+KF69bqr9Yf3rLeU8xTV8Yso
	3VogvnT3iYznJnYfNpkEBcv9sDk+Tyo0NHKrr3Cti+C9QtuXzv8jStPlG/m9n/ztdPdQClvu
	9VdXTOfdz3W/jntu+MExaemMO7uXb9zWd2uL9S2zaUtkT9ZOUrHevD8k4PwEvn4HG3V3Ji8B
	Vs1fza4VceX50+cLrbKNTZD8UygmUby3P12JpTgj0VCLuag4EQDrGuKpuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7r7ZCLSDa7sVbG4M+k5u8W6t+dZ
	LS7vmsNm0TD7O6vFjQlPGS2WfnnHbLF0xVtWi82bpjI7cHh8vXmOyWPBplKPTas62TzenTvH
	7rF+y1UWj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
	MstSi/TtEvQyZr9cwFhw06ei/+Rv5gbGJzZdjJwcEgImEr9f7WDuYuTiEBJYyiixsfMDO0RC
	RmLjl6usELawxJ9rXWwgtpDAR0aJd3OCIRp2Mkps//0JLMErYCdx/94zsGYWAVWJDTPvMkHE
	BSVOznzCAmKLCshL3L81A6xGWCBXou3aM7A4s4C4RNOXlUDLODhEBFQkLj1yBJnPLNDNJLHz
	8GJ2iMUbWCT2veIHsdkENCX2ndwEFucUsJFY8mwHO8QcC4nFbw5C2fISzVtnM0M8oCgxY+JK
	Fgi7VuLz32eMExhFZyE5bxaSM2YhGTULyagFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcx
	AuN527GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRFeDu/QdCHelMTKqtSi/Pii0pzU4kOMpsAwmsgs
	JZqcD0woeSXxhmYGpoYmZpYGppZmxkrivGxXzqcJCaQnlqRmp6YWpBbB9DFxcEo1MIm1HJwb
	saP2Xo9F8T7L59P7zRKzFJ5fK7zo+sS+68bjaSoPBL5mnGKY9TRNSujrucdrokxYvNoOZ6+b
	lhfbtGv9uajUGv3rRu8uL15XMcNy/YPPyco2MfPn/AiZKBdh8mKfm0iNyEvtF3UB3iIzxSIP
	bV/vqmMn9EbHxaNN+/yVhQf3xmW2Gyj5T+m6wrPUvrxOMd7rveXevNyfV1+ccNp9L+RQVVRo
	8bY/vO/YIqsTvnjILvrjWDq/gNnoZ+KMw9O+mF2Q2vymv7xz195JO6esfL/4clxBZNRMfn/m
	4LenHc75Ky+71Hf3TyyT3/bNwTPOdWtnph/d8Z9hTRnP/wbTQzc277vML/g0qS7Jd4MSS3FG
	oqEWc1FxIgCrpqvPcAMAAA==
X-CMS-MailID: 20241210104934eucas1p19459af12d0e83f45f9183eb1ab287757
X-Msg-Generator: CA
X-RootMTR: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
	<CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
	<164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
	<D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
	<b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
	<D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
	<7fdcf601-524b-4530-861d-e4b0f8c1023b@suse.com>
	<9734d93d-73c8-464e-8f32-6117c6f6c952@samsung.com>
	<cee55e3b-9028-4f56-8ac6-9895ca383334@suse.com>

On 12/4/2024 4:14 PM, Petr Pavlu wrote:
> On 11/28/24 21:23, Daniel Gomez wrote:
>> On 11/12/2024 3:35 PM, Petr Pavlu wrote:
>>> On 11/12/24 10:43, Daniel Gomez wrote:
>>>> On Mon Nov 11, 2024 at 7:53 PM CET, Christophe Leroy wrote:
>>>>>
>>>>>
>>>>> Le 09/11/2024 à 23:17, Daniel Gomez a écrit :
>>>>>> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>>>>>>> Once module init has succeded it is too late to cancel loading.
>>>>>>> If setting ro_after_init data section to read-only fails, all we
>>>>>>> can do is to inform the user through a warning.
>>>>>>>
>>>>>>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>> Closes: https://protect2.fireeye.com/v1/url?k=d3deb284-b2a35ac3-d3df39cb-74fe485fff30-288375d7d91e4ad9&q=1&e=701066ca-634d-4525-a77d-1a44451f897a&u=https%3A%2F%2Feur01.safelinks.protection.outlook.com%2F%3Furl%3Dhttps%253A%252F%252Flore.kernel.org%252Fall%252F20230915082126.4187913-1-ruanjinjie%2540huawei.com%252F%26data%3D05%257C02%257Cchristophe.leroy%2540csgroup.eu%257C26b5ca7363e54210439b08dd010c4865%257C8b87af7d86474dc78df45f69a2011bb5%257C0%257C0%257C638667874457200373%257CUnknown%257CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%253D%253D%257C0%257C%257C%257C%26sdata%3DZeJ%252F3%252B2Nx%252FBf%252FWLFEkhxKlDhZk8LNkz0fs%252Fg2xMcOjY%253D%26reserved%3D0
>>>>>>> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>> ---
>>>>>>>     kernel/module/main.c | 6 +++---
>>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>>>> index 2de4ad7af335..1bf4b0db291b 100644
>>>>>>> --- a/kernel/module/main.c
>>>>>>> +++ b/kernel/module/main.c
>>>>>>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
>>>>>>>     #endif
>>>>>>>     	ret = module_enable_rodata_ro_after_init(mod);
>>>>>>>     	if (ret)
>>>>>>> -		goto fail_mutex_unlock;
>>>>>>> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
>>>>>>> +			mod->name, __func__, ret);
>>>>>>> +
>>>>>>>     	mod_tree_remove_init(mod);
>>>>>>>     	module_arch_freeing_init(mod);
>>>>>>>     	for_class_mod_mem_type(type, init) {
>>>>>>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
>>>>>>>     
>>>>>>>     	return 0;
>>>>>>
>>>>>> I think it would make sense to propagate the error. But that would
>>>>>> require changing modprobe.c. What kind of error can we expect when this
>>>>>> happens?
>>>>>
>>>>> AFAIK, on powerpc it fails with EINVAL when
>>>>> - The area is a vmalloc or module area and is a hugepage area
>>>>> - The area is not vmalloc or io register and MMU is not powerpc radix MMU
>>>>>
>>>>> Otherwise it propagates the error from apply_to_existing_page_range().
>>>>> IIUC it will return EINVAL when it hits a leaf PTE in upper directories.
>>>>
>>>> Looking at that path I see we can also fail at __apply_to_page_range()
>>>> -> apply_to_p4d_range() and return with -ENOMEM.
>>>>
>>>> My proposal was to do something like the change below in modprobe:
>>>>
>>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>>> index ec66e6f..8876e27 100644
>>>> --- a/tools/modprobe.c
>>>> +++ b/tools/modprobe.c
>>>> @@ -572,6 +572,11 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>>>                   err = 0;
>>>>           else {
>>>>                   switch (err) {
>>>> +               case -EINVAL:
>>>> +                       ERR("module '%s'inserted: ro_after_init data might"
>>>> +                           "still be writable (see dmesg)\n",
>>>> +                           kmod_module_get_name(mod));
>>>> +                       break;
>>>>                   case -EEXIST:
>>>>                           ERR("could not insert '%s': Module already in kernel\n",
>>>>                               kmod_module_get_name(mod));
>>>>
>>>> But I think these error codes may be also be reported in other parts
>>>> such as simplify_symbols() so may not be a good idea after all.
>>>
>>> It isn't really possible to make a sensible use of the return code from
>>> init_module(), besides some basic check for -EEXIST. The problem is that
>>> any error code from a module's init function is also propagated as
>>> a result from the syscall.
>>>
>>>>
>>>> Maybe we just need to change the default/catch all error message in
>>>> modprobe.c and to indicate/include this case:
>>>>
>>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>>> index ec66e6f..3647d37 100644
>>>> --- a/tools/modprobe.c
>>>> +++ b/tools/modprobe.c
>>>> @@ -582,7 +582,8 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>>>                               kmod_module_get_name(mod));
>>>>                           break;
>>>>                   default:
>>>> -                       ERR("could not insert '%s': %s\n", kmod_module_get_name(mod),
>>>> +                       ERR("could not insert '%s' or inserted with error %s, "
>>>> +                           "(see dmesg)\n", kmod_module_get_name(mod),
>>>>                               strerror(-err));
>>>>                           break;
>>>>                   }
>>>>
>>>>
>>>>>
>>>>> On other architectures it can be different, I know some architecture try
>>>>> to split the pages when they hit hugepages and that can fail.
>>>>
>>>> Is it worth it adding an error code for this case in case we want to
>>>> report it back?
>>>
>>> I feel that the proposed kernel warning about this situation is
>>> sufficient and the loader should then return 0 to indicate that the
>>> module got loaded. It would be more confusing to return an error but
>>> with the module actually remaining inserted.
>>>
>>> A module loaded without having its RO-after-init section changed
>>> properly to RO is still fully functional. In practice, if this final
>>> set_memory_ro() call fails, the system is already in such a state where
>>> the additional warning is the least of the issues?
>>>
>>
>> __ro_after_init is used for kernel self protection. We are loading
>> "successfully" the module yes, but variables with this attribute are
>> marked read-only to reduce the attack surface [1]. Since we have
>> considered this stage already too late to unload the module, IMHO we
>> should at least indicate that there was an error during the module
>> initialization and propagate that to the loader, so it can decide the
>> best action for their particular case. Warning once in the kernel log
>> system, does not seem sufficient to me.
>>
>> [1] Documentation/security/self-protection.rst
> 
> I'd be careful about introducing this new state where (f)init_module()
> returns an error, yet the module actually gets loaded.

Perhaps we just need this new stage? module loaded with 
permission/security error?

> 
> The init_module() interface has one return value which can originate
> from anywhere during the load process, including from the module's own
> init function. As mentioned, this means that the userspace cannot
> distinguish why the module load failed. It would be needed to have
> a specific error code returned only for this case, or to extend the
> interface further in some way.
> 
> Another concern is consistency of the module loader interface as
> a whole. Returning an error from init_module() in this case would mean
> that only the specific caller is made aware that the module was loaded
> with some issues. A different task that then decides to check the module
> state under /sys/module would see it as normally loaded, and similarly a

Maybe we need to change this state too to indicate the problem.

> task trying to insert it again would get -EEXIST. That likely would need
> changing too.
> 
> What I'd like to understand is how reporting this as an error to the
> userspace would help in practice. I think the userspace can decide to
> report it as a warning and continue, or treat is as a hard problem and
> stop the system? I would expect that most tools/systems would opt for
> the former, but then this doesn't seem much different to me than when
> the kernel produces the warning itself. The second option, with some
> stretch, could be implemented with panic_on_warn=1.

Ideally, we would reverse the module initialization when encountering 
this error [1]. However, since it's not feasible to undo it correctly at 
this stage, reporting the error back to the caller allows them to assess 
and decide whether to accept the risk.

[1] https://lore.kernel.org/all/Zuv0nmFblHUwuT8v@bombadil.infradead.org/
> 
> Do you envision that the userspace would handle this problem differently
> and it is worth adding the complexity?

What complexity do you mean?

A module driver has ro_after_init for the purpose of protecting the 
kernel from attack [2]. If we ignore it by warning once, the caller will 
not be aware of such risk (unless the caller it's parsing the kernel log).

[2] 
https://lore.kernel.org/all/1455748879-21872-1-git-send-email-keescook@chromium.org/

Another option could be adding a kconfig to decide to report or not 
which I would strongly suggest to report by default.


> 
> As a side node, I've noticed that the module loader could mark also
> static_call sections as ro_after_init. I'll post patches for that.
> Additionally, both __jump_table and static_call sections could be
> possibly turned RO earlier, after prepare_coming_module() ->
> blocking_notifier_call_chain_robust() -> ... ->
> jump_label_add_module()/static_call_add_module().
> 

