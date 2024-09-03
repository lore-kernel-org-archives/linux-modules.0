Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48C8489
	for <linux-modules@vger.kernel.org>; Tue,  3 Sep 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376321; cv=none; b=kdHRHS7VU235vNzmm4pux7IaKIg53N2/VlKIDn2ZJt8hZiM3xjBHS+z72kHx5zr2k8MxzruDDZzLipUJ48sCprM127KXBfMgAn/2pmhCXz37hsML08h3CAVDuRGbs28UTCZ9V9GREzChA87vTRNtjuqq++Azl9E8oruBKVX+sk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376321; c=relaxed/simple;
	bh=HaQoSOeNV+l72P3AJuWZoCj9lxSZl2+1ZxYqkRtwfCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8INmuMHfhkqL/e/ondiWOBxDB15zT+JauIs76S6QbSImQA7EZBft37zZc3D/RlzvD4cox/qS3VgRwA8Aq/j/XcurBG3QMroQouzVKgFXq+KHwm2TnEgPFYIdlMPsv4TtSImbBOd4mDPuXOELLO475oYDNFjVAxfclJWJFEEXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXOBeDS4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXOBeDS4"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86883231b4so650747966b.3
        for <linux-modules@vger.kernel.org>; Tue, 03 Sep 2024 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725376318; x=1725981118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8WDyM7wA+4uXBEwvEfZ6K89F1ujUbboR8QatKwOx+kg=;
        b=IXOBeDS4oCGAf/Gz3mqX9hKKukL0qrRfs9tZPRq2GoV2182iaU/hC81nSQ8PtlLBmK
         sSy+rLMTANh6Z5+T9hJBZJSbFnU6cxwbCMuMN5eYJc/0ZI4ZPhX0662K/t4cpqIna708
         dPYLtqEvXgiAs8A8KXdS6ZVBNs4aH/Dx7Hmd+oHi29n+fFq2M2p2IrzTB0lINVY1mKKR
         lhHyUcGNwIBk9AsNXfnLo0cJXnYpPBo74M9qxrIiOKzL92ChsWBS7whKEx4mEcmsU/mt
         ipRkJ1oqW9XWEwyrqoUb5iKaQECVjUtvw1y522pnfHK/a5qHxCkzvQZMOVUUWLJHK5g8
         r6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376318; x=1725981118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WDyM7wA+4uXBEwvEfZ6K89F1ujUbboR8QatKwOx+kg=;
        b=C5HSauugifvAZDFUh6srmMkUeFBkKjfHMMJ5ymwoBbDSViQ9BqMu8IhfEJ97tgGjiA
         J5wQ6247QrCeX6j8f4P8mDnKdNK5PFpfsxjev/TL6RRMs0kAbjqjEKnF8rOpKWSjvCil
         vZphZyhsA3yeR6EXnmt8ABo5gTyuE4eYBl205nNAZEur41J7iYW5iENEB6v95BGQjmst
         dU+d9gNq2n3mIWDfqx4OnCEKIS58s4B1AP6d3zxmHmYjLU/Ys20DcnEhE3ZIMqAYiWxY
         hymz22Qbc0iVN05vG1qSTU0arOII8ySDMVv0aj9j7nWTcwnLvoA/vzTerBbGj00GwD76
         pOew==
X-Forwarded-Encrypted: i=1; AJvYcCV88xVxTk8LGmdkcOjnuFVyISoTZOJ8WCPVqep031R6sdy6k2cvgvHs6arczVr4tvWjUcO6sIccJiAQacy1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47I8owyI6D0WRio7HUe4Ippw33tyadsM3R9ACqMQo/WZRDNi5
	NHQnxDSdBW5RL457m+8JAyg65JwJkBpXlPymFDNz7P3AL3SxrKsWge9CSVSMLMc=
X-Google-Smtp-Source: AGHT+IFoUUFxcVhHxWppSsUC1TKbkdYIP8izH9TlTs0zzWQ7ixgWt0bHVTTPOJbkicRNtP6gPNtD2A==
X-Received: by 2002:a17:906:ef0d:b0:a80:f7db:3e7 with SMTP id a640c23a62f3a-a89d87216d1mr821251966b.5.1725376318249;
        Tue, 03 Sep 2024 08:11:58 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196500sm695054466b.138.2024.09.03.08.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:11:57 -0700 (PDT)
Message-ID: <9978884e-87c8-4c20-b9ff-b4571bce01ce@suse.com>
Date: Tue, 3 Sep 2024 17:11:57 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/19] gendwarfksyms: Expand subroutine_type
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-29-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240815173903.4172139-29-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 19:39, Sami Tolvanen wrote:
> Add support for expanding DW_TAG_subroutine_type and the parameters
> in DW_TAG_formal_parameter. Use this to also expand subprograms.
> 
> Example output with --debug:
> 
>   subprogram(
>     formal_parameter base_type usize byte_size(8),
>     formal_parameter base_type usize byte_size(8),
>   )
>   -> base_type void;
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/gendwarfksyms/dwarf.c         | 57 ++++++++++++++++++++++++++-
>  scripts/gendwarfksyms/gendwarfksyms.h |  1 +
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> index 82185737fa2a..c81652426be8 100644
> --- a/scripts/gendwarfksyms/dwarf.c
> +++ b/scripts/gendwarfksyms/dwarf.c
> [...]
>  
> +static int __process_subroutine_type(struct state *state, struct die *cache,
> +				     Dwarf_Die *die, const char *type)
> +{
> +	check(process(state, cache, type));
> +	check(process(state, cache, "("));
> +	check(process_linebreak(cache, 1));
> +	/* Parameters */
> +	check(process_die_container(state, cache, die, process_type,
> +				    match_formal_parameter_type));
> +	check(process_linebreak(cache, -1));
> +	check(process(state, cache, ")"));
> +	process_linebreak(cache, 0);
> +	/* Return type */
> +	check(process(state, cache, "-> "));
> +	return check(process_type_attr(state, cache, die));
> +}

If I understand correctly, this formatting logic also affects the
symtypes output. Looking at its format, I would like to propose a few
minor changes.

Example of the current symtypes output:
kprobe_event_cmd_init subprogram( formal_parameter pointer_type <unnamed> { s#dynevent_cmd } byte_size(8), formal_parameter pointer_type <unnamed> { base_type char byte_size(1) encoding(8) } byte_size(8), formal_parameter base_type int byte_size(4) encoding(5),  ) -> base_type void

Proposed changes:
kprobe_event_cmd_init subprogram ( formal_parameter pointer_type <unnamed> { s#dynevent_cmd } byte_size(8) , formal_parameter pointer_type <unnamed> { base_type char byte_size(1) encoding(8) } byte_size(8) , formal_parameter base_type int byte_size(4) encoding(5) ) -> base_type void
                                ^- (1)                                                                    ^- (2)                                                                                                                                                       ^- (3)

(1) "subprogram(" is split to "subprogram (".
(2) A space is added prior to ",".
(3) String ", " is removed after the last parameter.

Separating each token with a whitespace matches the current genksyms
format, makes the data trivially parsable and easy to pretty-print by
additional tools. If some tokens are merged, as in "subprogram(", then
such a tool needs to have extra logic to parse each word and split it
into tokens.

For attributes with one value, such as "byte_size(4)", I think the
current format is probably ok.

-- 
Thanks,
Petr
