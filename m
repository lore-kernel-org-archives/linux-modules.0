Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FA8F5A;
	Sat,  4 Jan 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735977006; cv=none; b=qJl/y7hXwZwE8iWBnh8Ui/zfqjBlbs8JeXcthSAoconH6eaQTZCsdGKA7gUi64xfELper+8EUpFiLLrUGX6StTu+PZHRUWDFzJiWn93DsRR8+GZs8+yqbLNZKqRwwni0nhF6vbDAUaq2XeRKUA/38RpeUpJzprAr61PeBQkAw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735977006; c=relaxed/simple;
	bh=rnERQSRc9VbgAoql2qdy22rvm/Qtmnybq4mYJFpAz3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BT96G+nHnumgcJpU/YbOgKtstauflKfCII9dSQVa9jJfnUHw0rKbvGkeftva6bjRGcaVzEIzYVXLxix0Vf/3a1E1IDJnDlFPjdH6kNgeX2aT2UIOSV6NKvOKA6ouUflhbVqcFAFF63pGve6d1AH8o6ZD5WKuqHnTZaWd+CFaMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YQC4S1L5Nz9shx;
	Sat,  4 Jan 2025 08:39:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4o1KxS0RS-V; Sat,  4 Jan 2025 08:39:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YQC4S0QWPz9sSs;
	Sat,  4 Jan 2025 08:39:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EF2808B76D;
	Sat,  4 Jan 2025 08:39:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Ox2ziK35jecc; Sat,  4 Jan 2025 08:39:03 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8527B8B763;
	Sat,  4 Jan 2025 08:39:03 +0100 (CET)
Message-ID: <3a961c7a-d793-4319-ab78-af11f46587ff@csgroup.eu>
Date: Sat, 4 Jan 2025 08:39:03 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
 <f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/01/2025 à 17:13, Petr Pavlu a écrit :
> On 12/5/24 20:46, Christophe Leroy wrote:
>> This series reworks module loading to avoid leaving the module in a
>> stale state when protecting ro_after_init section fails.
>>
>> Once module init has succeded it is too late to cancel loading.
>> If setting ro_after_init data section to read-only fails, all we can
>> do is to inform the user through a warning. This is what patch 2 does.
>>
>> Then patch 3 tries to go a bit further by testing the ability to write
>> protect ro-after-init section prior to initialising the module.
> 
> I've been holding off on applying this series to modules-next because
> there was still some discussion on the previous RFC version [1], and
> I wanted to give people more time to potentially comment.
> 
> Mike Rapoport also recently posted a series with a patch [2] that
> proposes restoring of large pages after fragmentation. Should the last
> patch here be then dropped?

Indeed, if the large pages are restored when bringing back the 
ro_after_init to RW, it defeats the purpose of patch 3.

So I agree, let's first apply patches 1 and 2 in order to fix the actual 
bug then see how we can improve as a second step.

> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-modules%2F737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy%40csgroup.eu%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ce1338eec4ee742a40b6208dd2c1192dc%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638715176198708012%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=B7qL4g0NUqBqdREndab5kywoOu2wsNYej6hqnIH10tk%3D&reserved=0
> [2] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-modules%2F20241227072825.1288491-4-rppt%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ce1338eec4ee742a40b6208dd2c1192dc%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638715176198723794%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=eMxPsu43ByOjr7ny9Xg81ylWS6853dTU5MmU3J9e2hc%3D&reserved=0
> 

