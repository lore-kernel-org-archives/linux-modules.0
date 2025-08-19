Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2727B328
	for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615039; cv=none; b=a700ncQFJYHkSAOBSJDQGcbYZTp1tfNTryuQqOS5Hz6AY99D2j0qugVBd6JPOdYQ05+A0eAa8qUv+rh7uoEAXqDCz8J1xYbp9nFG3/Yi2QX9+3kgPKIKJZoyNgxubyftUPqCCgoDee4RaNB/Ppp64oUsEo/B4psru9UwZKPkrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615039; c=relaxed/simple;
	bh=dfXnpGmZu6otv8S2trWLiAUGAQkEFm6zwDyTZXGzLlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZfZtnmzXdhTp/tpRy88rxB8lkInkEwauNAZo0lPdmtDYhaPQk474gCDL2KpXEMvkSaNE+nLqZ6la3X/+aGIhhdlO3Z2jGuxFEvAwCxdQiR1bz0OnDiUc+S8WMQbrc/1JhCOklRuwknTVS8jh5ssLJ29jHnFRnvium2BdHXU0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c5sVQ5kXRz9sRs;
	Tue, 19 Aug 2025 16:32:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3z4CdriRej1; Tue, 19 Aug 2025 16:32:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c5sVQ4gLqz9sRg;
	Tue, 19 Aug 2025 16:32:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A4298B769;
	Tue, 19 Aug 2025 16:32:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 8yzwSu50ZqDe; Tue, 19 Aug 2025 16:32:14 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 298488B763;
	Tue, 19 Aug 2025 16:32:14 +0200 (CEST)
Message-ID: <48f2aad1-a34d-4848-9dd3-2f984d6dd349@csgroup.eu>
Date: Tue, 19 Aug 2025 16:32:13 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 Petr Pavlu <petr.pavlu@suse.com>
Cc: Phil Sutter <phil@nwl.cc>, linux-modules@vger.kernel.org,
 Yi Chen <yiche@redhat.com>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
 <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
 <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
 <02be4b86-330e-4f93-ba79-8218d05659ba@suse.com>
 <i4ayzta5zgltyubg6bfr4mwqhl6goyh73lyc7j7m3vngvpooi3@boorlngxpi52>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <i4ayzta5zgltyubg6bfr4mwqhl6goyh73lyc7j7m3vngvpooi3@boorlngxpi52>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/08/2025 à 16:17, Lucas De Marchi a écrit :
> On Tue, Aug 19, 2025 at 10:52:16AM +0200, Petr Pavlu wrote:
>> On 8/18/25 11:34 AM, Phil Sutter wrote:
>>> On Sun, Aug 17, 2025 at 05:54:27PM +0200, Christophe Leroy wrote:
>>>> Le 17/08/2025 à 01:33, Phil Sutter a écrit :
>>>>> [Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez 
>>>>> pourquoi ceci est important ? https://aka.ms/ 
>>>>> LearnAboutSenderIdentification ]
>>>>>
>>>>> Hi,
>>>>>
>>>>> I admittedly didn't fully analyze the cause, but on my system a 
>>>>> call to:
>>>>>
>>>>> # insmod /lib/module/$(uname -r)/kernel/net/netfilter/ 
>>>>> nf_conntrack_ftp.ko
>>>>>
>>>>> fails with -EEXIST (due to a previous call to 'nfct add helper ftp 
>>>>> inet
>>>>> tcp'). A call to:
>>>>>
>>>>> # modprobe nf_conntrack_ftp
>>>>>
>>>>> though returns 0 even though module loading fails. Is there a bug in
>>>>> modprobe error status handling?
>>>>>
>>>>
>>>> Read the man page : https://eur01.safelinks.protection.outlook.com/? 
>>>> url=https%3A%2F%2Flinux.die.net%2Fman%2F8%2Fmodprobe&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2c842a011e454a06da1708dddf2b37a7%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638912098887559261%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=QFjpi0HYpLQjzCxuNLgEtq44XzUbyKy8VRAGec5H7Ok%3D&reserved=0
>>>>
>>>> In the man page I see:
>>>>
>>>>             Normally, modprobe will succeed (and do nothing) if told to
>>>> insert a module which is already present or to remove a module which
>>>> isn't present.
>>>
>>> This is not a case of already inserted module, it is not loaded before
>>> the call to modprobe. It is the module_init callback
>>> nf_conntrack_ftp_init() which returns -EEXIST it received from
>>> nf_conntrack_helpers_register().
> 
> is this a real failure condition or something benign like "if it's
> already registered, there's nothing to do"?

My understanding from Phil's explanation is: it is something serious 
that says something like "There is already something else registered on 
that UDP Port, I can't register the conntrack helper on that port".

Christophe

> 
>>>
>>> Can't user space distinguish the two causes of -EEXIST? Or in other
>>> words, is use of -EEXIST in module_init callbacks problematic?
>>
>> Unfortunately, error return codes from (f)init_module cannot be reliably
>> depended upon. For instance, cpufreq drivers have similar behavior of
>> returning -EEXIST when another cpufreq driver is already registered.
>> Returning this code unexpectedly can then confuse kmod, as it interprets
>> -EEXIST to mean "the module is already loaded" [1].
> 
> well, it's not that it can't be relied on. There's 1 exit code that is
> treated specially, EEXISTS, because that error is used by the module
> loading part, before the module_init call, to signify the module is
> already loaded.
> 
>>
>> I have thought about this problem before. We might fix the main
>> problematic occurrences, but we can't really audit all the code that
>> module init functions can invoke. I then wonder if it would make sense
>> for the module loader to warn about any -EEXIST returned by a module's
>> init function and translate it to -EBUSY.
> 
> If it's a failure condition then yes, -EBUSY looks appropriate.
> 
> Lucas De Marchi
> 
>>
>> Ensuring the reliability of the 0 and -EEXIST return codes from
>> (f)init_module should help user space.
>>
>> [1] https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fkmod- 
>> project%2Fkmod%2Fblob%2F695fd084a727cf76f51b129b67d5a4be1d6db32e%2Flibkmod%2Flibkmod-module.c%23L1087&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2c842a011e454a06da1708dddf2b37a7%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638912098887579771%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=A2B0UH9D47p53Jif4ppLAaiDl6MDIX6ZFjUNik5Cmis%3D&reserved=0
>>
>> -- Petr

