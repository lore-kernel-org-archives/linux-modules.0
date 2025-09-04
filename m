Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8EE29AB15
	for <linux-modules@vger.kernel.org>; Thu,  4 Sep 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970437; cv=none; b=tYvWZsd5EHiq/fxnUvIQuMplWNfRf77sSmTD1HouAVdJuDz2DmzZ7RDkVn0lbvW9/hrgyr2etFEik5swoPupBLafahhU0HDQHOgr4pk9wpCkp2190O5BDUlZ+OjIQ9eGkUHTw+luS5wRUBf8QpqriKgAk8AkfHwM6yLd8utOJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970437; c=relaxed/simple;
	bh=a8z3HMGq17q6vHp3fu2bkktO6P68ezfpZyEn0WFvTs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=swTMwltv8Bgk/pYYM8poFqhwcaOhCW1rev5LX7NJO6IA7NNWhBIBA/nJHqxhIyqppKlZVWm7co9ScfdAd2fh1GqQFLlE7c1K/4uT16s3fsU4pt+hu0QJ1sdHP8/k2jStoQuE+gJ2jbxR3rEufOESj5cU2Zec+Xlu5xDIs8sJ6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cHW1x3QJkz9sVl;
	Thu,  4 Sep 2025 09:14:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2kdusz8gaKW; Thu,  4 Sep 2025 09:14:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cHW1x2g6Bz9sVk;
	Thu,  4 Sep 2025 09:14:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4512F8B764;
	Thu,  4 Sep 2025 09:14:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3J62ZvdVNPwi; Thu,  4 Sep 2025 09:14:29 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 220558B763;
	Thu,  4 Sep 2025 09:14:29 +0200 (CEST)
Message-ID: <8c8fa4e8-0c81-4697-b620-696adf8e50e0@csgroup.eu>
Date: Thu, 4 Sep 2025 09:14:28 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: a module for wiping userspace RAM before
 shutdown/reboot/halt
To: Kamil Aronowski <kamil.aronowski@3mdeb.com>,
 Danill Klimuk <daniil.klimuk@3mdeb.com>, linux-modules@vger.kernel.org,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <bfe72929-ba4c-4732-9f80-25cc7b95a0c8@3mdeb.com>
 <eb88e58f-1515-4f51-8102-79cd3c20fea5@3mdeb.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <eb88e58f-1515-4f51-8102-79cd3c20fea5@3mdeb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+mm list

Hi Kamil,

Le 21/08/2025 à 14:13, Kamil Aronowski a écrit :
> Recently, we evaluated the effectiveness of the `init_on_free`
> mechanism, particularly in the context of preserving privacy by
> clearing RAM for individuals with high operational security
> requirements.
> 
> As mentioned
> (https://lore.kernel.org/all/e71bd62c-5ba7-4363-9af1- 
> d9c9de394a54@3mdeb.com/),
> we'd like to ensure that our clients do not have their confidential
> data leaked after their session has ended with a shutdown/reboot/halt.
> 
> In short, `init_on_free` appears to wipe the LUKS secret key
> successfully, but some non-kernel space snippets remain in memory.
> Some tests have been performed by dumping memory after booting Debian
> 13 (with `init_on_free` enabled) and then rebooting to our custom EFI
> memory dumping application.  For instance, the mentions of
> `apparmor_parser`, XKB, udev, or systemd units have been found in the
> memory dump:
> 
> ```
> audit: type=1400 audit(1755156467.556:2): apparmor="STATUS" 
> operation="profile_load" profile="unconfined" name="Discord" pid=967 
> comm="apparmor_parser"r"
> [...]
> 
> partial alphanumeric_keys
> xkb_symbols "tib_asciinum" {
>      include "cn(tib)"
>      name[Group1]= "Tibetan (with ASCII numerals)";
>      key <AE01> { [ 1, 0x1000f21, 0x1000f04, 0x1000f76 ] }; # 1
> [...]
> 
> I:10114000
> E:ID_MM_CANDIDATE=1
> S:disk/by-id/dm-uuid-CRYPT-LUKS2-00b4b79c209a4dcfadf37e310778f583- 
> sda3_crypt
> [...]
> 
> [Unit]
> Description=Switch Root
> AssertPathExists=/etc/initrd-release
> DefaultDependencies=no
> Wants=initrd-switch-root.service
> Before=initrd-switch-root.service
> AllowIsolate=yes
> Wants=initrd-udevadm-cleanup-db.service initrd-root-fs.target initrd- 
> fs.target systemd-journald.service initrd-cleanup.service
> After=initrd-udevadm-cleanup-db.service initrd-root-fs.target initrd- 
> fs.target emergency.service emergency.target initrd-cleanup.service
> [...]
> ```
> 
> Is this the expected behavior, a bug, or a misconfiguration on our
> end?
> 
> If it is indeed a bug, we'd be happy to cooperate on improving the
> `init_on_free` mechanism. If it is expected behavior than we will
> consider wiping userspace memory some other way, e.g. by implementing
> a separate Linux Kernel module as described in the previous email
> (https://lore.kernel.org/all/e71bd62c-5ba7-4363-9af1- 
> d9c9de394a54@3mdeb.com/).
> 

This topic seems to be a memory management topic, not a modules topic.

As I mentionned already in this thread, Linux memory management topics 
should be addressed to linux-mm@kvack.org

Christophe
