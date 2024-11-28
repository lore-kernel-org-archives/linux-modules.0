Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E01487C1
	for <linux-modules@vger.kernel.org>; Thu, 28 Nov 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825762; cv=none; b=VWwWpXnKdgMkFDx3c+MfwcUet/5QCVAh+bvcs6Pu5GhUuptQd/JaPNbgfnke0e/EYV4QCV7Se6lfIzsMDskdqQi4L7CiaLh0jSQncQRELUiNMz4wzw8JmQQ+o+RybPtZQk3B27QqPOQjc2z6E1n4XDzesRtAcvjlIqk2p4asI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825762; c=relaxed/simple;
	bh=gSbN/bGOz/QLTMl5qB+s9KsvDP66smZaJ+2jmyaP17M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=O8ZsFQ6YmGREbxbJWCXTAJbQzxw6RUcwhZox7PbXFujq5kAbG8Y7DOQGzTGmEep7H2u+63ZyA1unFkdt1dNaFf/TOHM5PveBOchsUiR+gvctiEaDi+OmoxAxxQrWXPK0VRkEnn7eyrdYliA5jfVKUvFcmsPPm2KcEPiopNRojY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vcx5dUIn; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vcx5dUIn"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241128202305euoutp0269fbf73392493be17237f1e358fd2760~MO4HkWgzg0267102671euoutp02R
	for <linux-modules@vger.kernel.org>; Thu, 28 Nov 2024 20:23:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241128202305euoutp0269fbf73392493be17237f1e358fd2760~MO4HkWgzg0267102671euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732825385;
	bh=y+q10bkOL9w4FuK6p31KnJ0WGqmE1h9vwYqr1VZyChc=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=vcx5dUInnW+lwEJNOU4nmYtbVVAD4TOVOMCxmmiw3zdBz5b7xr3cgjOSiCy2rk4Z4
	 MxVGq/1RoiwQkUKKAArrqsDmvdG+OlRZQEAjUXKluW0ZaeWe+xoGgNnRXH/S6eF1KM
	 wyun3h4hxAWYWg9vUXE30MLHNTHqs3Z6IUQdG5tQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241128202305eucas1p1d72e8f91e61ccb92579bb0de7c17c9ad~MO4HTfjIL2152821528eucas1p1c;
	Thu, 28 Nov 2024 20:23:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.DD.20409.921D8476; Thu, 28
	Nov 2024 20:23:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241128202305eucas1p2f46fc99c486bb277bc8017b046a5e229~MO4HCkMII0190401904eucas1p2G;
	Thu, 28 Nov 2024 20:23:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241128202305eusmtrp2a01bc2ee3dbdb30a9c314df170530d82~MO4HB-c6Q2184221842eusmtrp2H;
	Thu, 28 Nov 2024 20:23:05 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-f1-6748d1295a32
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.B5.19920.921D8476; Thu, 28
	Nov 2024 20:23:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241128202304eusmtip1e29a44739c2f828953b8d85f95484767~MO4G3Q2Nu1175611756eusmtip1s;
	Thu, 28 Nov 2024 20:23:04 +0000 (GMT)
Received: from [106.110.32.87] (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 28 Nov 2024 20:23:04 +0000
Message-ID: <9734d93d-73c8-464e-8f32-6117c6f6c952@samsung.com>
Date: Thu, 28 Nov 2024 21:23:03 +0100
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
In-Reply-To: <7fdcf601-524b-4530-861d-e4b0f8c1023b@suse.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87qaFz3SDZ7fF7G4M+k5u8W6t+dZ
	LS7vmsNm0TD7O6vFjQlPGS2WfnnHbLF0xVtWi82bpjI7cHh8vXmOyWPBplKPTas62TzenTvH
	7rF+y1UWj8+b5ALYorhsUlJzMstSi/TtErgyzh89zVJw1ahi36W0Bsat6l2MHBwSAiYSHU8Y
	uxg5OYQEVjBK3PvK38XIBWR/YZR48WkRG4TzmVHixP6XrCBVIA03L9xngUgsZ5SYPG8eC1zV
	ss3f2SBm7WSUmD41A2QFr4CdRMPcfJAwi4CqxK/GM2CDeAUEJU7OfMICYosKyEvcvzWDHcQW
	FsiVaLv2DCzOLCAu0fRlJSvIGBEBFYlLjxxBVjELdDNJ7Dy8GKyeTUBTYt/JTWA2p4CNxP1t
	/xhB6pkFrCSmn/CEGCMv0bx1NjPE/YoSMyauZIGwayVObbnFBDJTQmA6p8St+1Ohilwk+k++
	YISwhSVeHd/CDmHLSPzfOZ8Jwk6XWLJuFtSgAok9t2exQkLUWqLvTA5E2FHi7ufNUGE+iRtv
	BSHO4ZOYtG068wRG1VlIATELycOzEB6YheSBBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS
	83M3MQKT0el/x7/sYFz+6qPeIUYmDsZDjBIczEoivFcWe6QL8aYkVlalFuXHF5XmpBYfYpTm
	YFES51VNkU8VEkhPLEnNTk0tSC2CyTJxcEo1MDVZdtqYB6u1XHCe1rD+6f8PpbvykypnTNZK
	5b70VuDkLo4bR8UyGqzD/c1bXDU+FMluP5e9sLAg8KK7u4i3j/THQs5Fe7vK78iZvFryru4e
	d1TRfwkN9V9/1wUvym1bGOh3sV7m0ds99e1+RgyGSnOzBOuKmo4evyzvwWvg5mN15+G2pFm3
	bPe66r7kd/UwWX10e5vdcV3hP3ltdmZJ+Qsn9VxQlOrePm0Lw5/wX4rH/nZFzJtwadPS5nfi
	TK9MCrb+XpNWMYVF51vPU+8b+YEyS9azvYtwuqfwVfrwcRdvj/C7K535+X2usSsy3g4qYdbO
	9r26OWj5I12j7WYi25OzuY/PyDTdeufoX7v/SizFGYmGWsxFxYkAb7eIZrUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7qaFz3SDX4fZba4M+k5u8W6t+dZ
	LS7vmsNm0TD7O6vFjQlPGS2WfnnHbLF0xVtWi82bpjI7cHh8vXmOyWPBplKPTas62TzenTvH
	7rF+y1UWj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
	MstSi/TtEvQyzh89zVJw1ahi36W0Bsat6l2MnBwSAiYSNy/cZ+li5OIQEljKKPF46gVWiISM
	xMYvV6FsYYk/17rYIIo+MkpsunmSCcLZyShx4/I39i5GDg5eATuJhrn5IA0sAqoSvxrPgDXz
	CghKnJz5hAXEFhWQl7h/awY7iC0skCvRdu0ZWJxZQFyi6ctKVpAxIgIqEpceOYKMZxboZpLY
	eXgxO8Suk8wSTyZfYQNpYBPQlNh3chPYIE4BG4n72/4xQgyykFj85iA7hC0v0bx1NjPEB4oS
	MyauZIGwayU+/33GOIFRdBaS+2YhuWMWklGzkIxawMiyilEktbQ4Nz232FCvODG3uDQvXS85
	P3cTIzCetx37uXkH47xXH/UOMTJxMB5ilOBgVhLhvbLYI12INyWxsiq1KD++qDQntfgQoykw
	kCYyS4km5wMTSl5JvKGZgamhiZmlgamlmbGSOK/b5fNpQgLpiSWp2ampBalFMH1MHJxSDUxb
	V72P/v2N8dj657v9LzZ8Ursbmv5O98gVxS/V04+GfYrxFClW3N4WuJ7l6yf3DzxNW1Ut3WKL
	lq9ae9+1bffRtMD/64+8rT3yKX+N7/cm5sXHr3/dnH6oo9Lw2tcLpgGc+Uszf+bVRLvHbgyM
	T1v1uaTl8UnGGBPPCXYz793zc7UIXnrq28obB42kr8woe7xC2O33945nu/7Zblsy9ybb4+kd
	h9a5XTpva/Y37t1Wfqe999jXRkycXy24r8Tv/L0PXv8sHkV+rZ+Vqi06dbfXfOZVOZ/7krgu
	+h04ldvwv/rlyimfy86b13NVKt19nSBVqtEYe7Fu5oKdKbu8czYmnSpurfggke1ot+iT7rav
	/UosxRmJhlrMRcWJAN6BLH5wAwAA
X-CMS-MailID: 20241128202305eucas1p2f46fc99c486bb277bc8017b046a5e229
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

On 11/12/2024 3:35 PM, Petr Pavlu wrote:
> On 11/12/24 10:43, Daniel Gomez wrote:
>> On Mon Nov 11, 2024 at 7:53 PM CET, Christophe Leroy wrote:
>>>
>>>
>>> Le 09/11/2024 à 23:17, Daniel Gomez a écrit :
>>>> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>>>>> Once module init has succeded it is too late to cancel loading.
>>>>> If setting ro_after_init data section to read-only fails, all we
>>>>> can do is to inform the user through a warning.
>>>>>
>>>>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>>>>> Closes: https://protect2.fireeye.com/v1/url?k=d3deb284-b2a35ac3-d3df39cb-74fe485fff30-288375d7d91e4ad9&q=1&e=701066ca-634d-4525-a77d-1a44451f897a&u=https%3A%2F%2Feur01.safelinks.protection.outlook.com%2F%3Furl%3Dhttps%253A%252F%252Flore.kernel.org%252Fall%252F20230915082126.4187913-1-ruanjinjie%2540huawei.com%252F%26data%3D05%257C02%257Cchristophe.leroy%2540csgroup.eu%257C26b5ca7363e54210439b08dd010c4865%257C8b87af7d86474dc78df45f69a2011bb5%257C0%257C0%257C638667874457200373%257CUnknown%257CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%253D%253D%257C0%257C%257C%257C%26sdata%3DZeJ%252F3%252B2Nx%252FBf%252FWLFEkhxKlDhZk8LNkz0fs%252Fg2xMcOjY%253D%26reserved%3D0
>>>>> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>> ---
>>>>>    kernel/module/main.c | 6 +++---
>>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>> index 2de4ad7af335..1bf4b0db291b 100644
>>>>> --- a/kernel/module/main.c
>>>>> +++ b/kernel/module/main.c
>>>>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
>>>>>    #endif
>>>>>    	ret = module_enable_rodata_ro_after_init(mod);
>>>>>    	if (ret)
>>>>> -		goto fail_mutex_unlock;
>>>>> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
>>>>> +			mod->name, __func__, ret);
>>>>> +
>>>>>    	mod_tree_remove_init(mod);
>>>>>    	module_arch_freeing_init(mod);
>>>>>    	for_class_mod_mem_type(type, init) {
>>>>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
>>>>>    
>>>>>    	return 0;
>>>>
>>>> I think it would make sense to propagate the error. But that would
>>>> require changing modprobe.c. What kind of error can we expect when this
>>>> happens?
>>>
>>> AFAIK, on powerpc it fails with EINVAL when
>>> - The area is a vmalloc or module area and is a hugepage area
>>> - The area is not vmalloc or io register and MMU is not powerpc radix MMU
>>>
>>> Otherwise it propagates the error from apply_to_existing_page_range().
>>> IIUC it will return EINVAL when it hits a leaf PTE in upper directories.
>>
>> Looking at that path I see we can also fail at __apply_to_page_range()
>> -> apply_to_p4d_range() and return with -ENOMEM.
>>
>> My proposal was to do something like the change below in modprobe:
>>
>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>> index ec66e6f..8876e27 100644
>> --- a/tools/modprobe.c
>> +++ b/tools/modprobe.c
>> @@ -572,6 +572,11 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>                  err = 0;
>>          else {
>>                  switch (err) {
>> +               case -EINVAL:
>> +                       ERR("module '%s'inserted: ro_after_init data might"
>> +                           "still be writable (see dmesg)\n",
>> +                           kmod_module_get_name(mod));
>> +                       break;
>>                  case -EEXIST:
>>                          ERR("could not insert '%s': Module already in kernel\n",
>>                              kmod_module_get_name(mod));
>>
>> But I think these error codes may be also be reported in other parts
>> such as simplify_symbols() so may not be a good idea after all.
> 
> It isn't really possible to make a sensible use of the return code from
> init_module(), besides some basic check for -EEXIST. The problem is that
> any error code from a module's init function is also propagated as
> a result from the syscall.
> 
>>
>> Maybe we just need to change the default/catch all error message in
>> modprobe.c and to indicate/include this case:
>>
>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>> index ec66e6f..3647d37 100644
>> --- a/tools/modprobe.c
>> +++ b/tools/modprobe.c
>> @@ -582,7 +582,8 @@ static int insmod_insert(struct kmod_module *mod, int flags, const char *extra_o
>>                              kmod_module_get_name(mod));
>>                          break;
>>                  default:
>> -                       ERR("could not insert '%s': %s\n", kmod_module_get_name(mod),
>> +                       ERR("could not insert '%s' or inserted with error %s, "
>> +                           "(see dmesg)\n", kmod_module_get_name(mod),
>>                              strerror(-err));
>>                          break;
>>                  }
>>
>>
>>>
>>> On other architectures it can be different, I know some architecture try
>>> to split the pages when they hit hugepages and that can fail.
>>
>> Is it worth it adding an error code for this case in case we want to
>> report it back?
> 
> I feel that the proposed kernel warning about this situation is
> sufficient and the loader should then return 0 to indicate that the
> module got loaded. It would be more confusing to return an error but
> with the module actually remaining inserted.
> 
> A module loaded without having its RO-after-init section changed
> properly to RO is still fully functional. In practice, if this final
> set_memory_ro() call fails, the system is already in such a state where
> the additional warning is the least of the issues?
> 

__ro_after_init is used for kernel self protection. We are loading 
"successfully" the module yes, but variables with this attribute are 
marked read-only to reduce the attack surface [1]. Since we have 
considered this stage already too late to unload the module, IMHO we 
should at least indicate that there was an error during the module 
initialization and propagate that to the loader, so it can decide the 
best action for their particular case. Warning once in the kernel log 
system, does not seem sufficient to me.

[1] Documentation/security/self-protection.rst


