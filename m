MIME-Version: 1.0
In-Reply-To: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
References: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
Date: Tue, 11 Apr 2017 09:10:17 -0700
Message-ID: <CAKi4VAJorR8Vwa49XV6s4x9b8opr=Wo_i10uagX-dw5euEDmFQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] modinfo: fix sig_id key and add signature output
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, Mark van Dijk <linux-modules@z.dvxs.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Apr 11, 2017 at 5:14 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Fix a small mistake in modinfo output, signat instead of sig_id.
> Implement signature hex ouput as people asked for it.
>
> Yauheni Kaliuta (4):
>   libkmod: modinfo: fix sig_id output
>   libkmod: modinfo: use own function for sig_key hex output
>   libkmod: modinfo: implement line splitting in hex_to_str
>   libkmod: modinfo: implement signature output

All 4 patches applied.

Thanks
Lucas De Marchi
