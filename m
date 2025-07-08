Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4B2989BF
	for <linux-modules@vger.kernel.org>; Tue,  8 Jul 2025 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960636; cv=none; b=i+VhXXM6aX/gbrlSbbboMg1eaq/y3qK7DUjA2SLQOZNSmHKeW458cgQJC+AG5plrjEi2EmiWmRVra6OIQkqmNTkyxPBHqIQ/BhMKO6u2o27l5ezWbh8jWh8dt3JmZJF6+cTzYDaPv0CE3IYpEkwy1LAAkW6608F0RdNxJIqRypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960636; c=relaxed/simple;
	bh=F5MpHapmLfuB6EvTtAG4tHy29JewS89LYG6Uev1XsUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjmrvbWEc62np//wmtfSSkbnmicNGcfbCs24QSYlxCRqePz95RPE1gI6Q3mhq4IlOBDPlDN2DERYIsgA4olHgYL5Kg66uA/o6tbejuzzJvjW/mjLSOXE9SjF7jBssgP24ftcoeH+QIpBJZuXcTz1CPX89ZbB8x2fKno3YDX8mt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYA0mAho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYA0mAho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751960633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PHZ3xvdg+8KBkT9ekm9uucUlDD68MoOhrjvY7t8qBig=;
	b=FYA0mAho1KmznhgmgviX3LSCDEnYBOHdMRGRq6j81QemHVnQblak3Nfgt4mIzl1/cEvde4
	ZjcYZZ72IFYrxHGWPPO076q7hectnkRhbEzZ7paaJsHDFfJ43PqfRLFHNSqxBymgbKjhUY
	aRNxrVhx4VngAxu5tZpdPbkMUjMNrpI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Ztyexe0KPNu8r1r9xkZWFg-1; Tue, 08 Jul 2025 03:43:51 -0400
X-MC-Unique: Ztyexe0KPNu8r1r9xkZWFg-1
X-Mimecast-MFC-AGG-ID: Ztyexe0KPNu8r1r9xkZWFg_1751960631
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so2474930f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 08 Jul 2025 00:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960630; x=1752565430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHZ3xvdg+8KBkT9ekm9uucUlDD68MoOhrjvY7t8qBig=;
        b=IPXU4npwrvKsCwvpGduTd8tvh/1NS9eXNQKfctWBBPw6GocrLXoz/CIvr46A3WSqIP
         IBNCGeTtFAYoMg2IukZ5rv4Q0N58a7xrfSifVuYF0eX5e8SdTpTG24uEodUXFf34Yayz
         uAdH2ghUizN+osK/K2Ubyk066zUi4LCPsbS9axSUXVfjzBrVWNzXEz2hFhQaO75afbba
         Bym1O9bYvjNOdn5kB3UM05ZGfi0mF7hcp2S2kLitAlMT4GNQKHv88gGZtrLCSswdyYlv
         KE4zGC8ulq4t4Ya+FTKWV/EPpTbq5SAXvTTvAzVr81TJBq66hbyrvfm9z4xcw/+NZbwu
         G2lw==
X-Forwarded-Encrypted: i=1; AJvYcCXQOGLo7mzppDLAwgBjcYVaD6jNfJ7WZzy/ly9+ADrJTq7ioE4YwnWwtDWZ9SQxnhqCY5+iveCzzA65Qgep@vger.kernel.org
X-Gm-Message-State: AOJu0Yytw2IcpN27+yg+qQhTZr1vhSgGLd0LQhbfiVl0WYcZTNkFFFlL
	xs4vw+nLngxYtjFAz2tmIjIKehYKz+b9UsO4ST1f2ISeFcUqH1XeQzuEaibN9D/RqNst8uI0qEQ
	GuDMc5LeI6ykmEItWgQhh9C7XFyWnAWbZ4Z5mhU9OLDAWdl4C2/RVbRpZTTaommPvQpU=
X-Gm-Gg: ASbGncvjZrE/3zCZqrJnVnE3k7YRhdMWVUuN5Hjch8jhR6nS9G2Ie3L0bOL7Vxar+P1
	A4qCE6IEvDxl7qbbCzZt8ENoQfiw+7eU83OBfBizGxC1g1x9nWJsrPai2VZipsrxB1ocY0LEyEs
	IG3WHz7Zsqc0AXs/hUFuXYr0M4LcrkqifqgfV6EHn1XrHCZ3XoeoPVxZ2VxI81kvoMSEeVBdHYN
	Q8i5bFEQseuwl/U/aF4UACV50KW5dGwVFSozdmhc5AzjEQ9NMpfYyI5SL1Ef9p1/VmqVpBuYjGx
	wGH8pMd1aYqqnIkuas6FfSl8nuahxq5ad9IwcwPr7PTu9y1Sp54FY0jb4iv8AtR/O6vu2hEsL9F
	gRCxPdEzpK7DC6xRP5fbAQTDj6GLkd+Y9U1I5jEp+cKzvjIojSA==
X-Received: by 2002:a05:6000:470f:b0:3b2:fe46:9812 with SMTP id ffacd0b85a97d-3b497015268mr10206010f8f.19.1751960630479;
        Tue, 08 Jul 2025 00:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdyLGgvPShNDAS1NZe5c9F4HjwpnyI4qzbk2LaZP5mfvehBW/XkwrJq9VQ/ULZcNouddeW3Q==
X-Received: by 2002:a05:6000:470f:b0:3b2:fe46:9812 with SMTP id ffacd0b85a97d-3b497015268mr10205981f8f.19.1751960629973;
        Tue, 08 Jul 2025 00:43:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f500:4346:f17c:2bde:808c? (p200300d82f1af5004346f17c2bde808c.dip0.t-ipconnect.de. [2003:d8:2f1a:f500:4346:f17c:2bde:808c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b975efsm12017650f8f.46.2025.07.08.00.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 00:43:49 -0700 (PDT)
Message-ID: <7b10d751-8e57-4cb9-b2a1-844695c95c73@redhat.com>
Date: Tue, 8 Jul 2025 09:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Restrict module namespace to in-tree modules and
 rename macro
To: Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Matthias Maennich <maennich@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Peter Zijlstra
 <peterz@infradead.org>, Shivank Garg <shivankg@amd.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
 <20250708-merkmal-erhitzen-23e7e9daa150@brauner>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250708-merkmal-erhitzen-23e7e9daa150@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.25 09:40, Christian Brauner wrote:
> On Tue, Jul 08, 2025 at 09:28:56AM +0200, Vlastimil Babka wrote:
>> Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
>> part to avoid controversy converting selected existing EXPORT_SYMBOL().
>> Christoph argued [2] that the _FOR_MODULES() export is intended for
>> in-tree modules and thus GPL is implied anyway and can be simply dropped
>> from the export macro name. Peter agreed [3] about the intention for
>> in-tree modules only, although nothing currently enforces it.
>>
>> It seems straightforward to add this enforcement, so patch 1 does that.
>> Patch 2 then drops the _GPL_ from the name and so we're left with
>> EXPORT_SYMBOL_FOR_MODULES() restricted to in-tree modules only.
>>
>> Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
>> in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
>> 8250: export RSA functions"). Hopefully it's resolvable by a merge
>> commit fixup and we don't need to provide a temporary alias.
>>
>> [1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
>> [2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
>> [3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
> 
> Love this. It'd be great to get this in as a bugfix,
> Acked-by: Christian Brauner <brauner@kernel.org>

Yes, looks like the right thing to do

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

