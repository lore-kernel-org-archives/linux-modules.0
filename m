MIME-Version: 1.0
In-Reply-To: <CAC0jrpN5e3bmS0EO+poA7cx0eLjH59BkWwAFuOmDX-qE6WGs-w@mail.gmail.com>
References: <CAC0jrpN5e3bmS0EO+poA7cx0eLjH59BkWwAFuOmDX-qE6WGs-w@mail.gmail.com>
Date: Thu, 14 Jan 2016 17:43:02 -0200
Message-ID: <CAKi4VA+ZsmP_xfQgD9XpoXidB=-JaMcpsAfG7v4-M2my3khVkg@mail.gmail.com>
Subject: Re: Support for PKCS#7 module signing.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Wouter van Kesteren <woutershep@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, David Howells <dhowells@redhat.com>,
	Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Wouter,


Sorry for the delay.

On Sun, Jan 10, 2016 at 10:15 PM, Wouter van Kesteren
<woutershep@gmail.com> wrote:
> Hello,
>
> I asked the following on irc, where it was suggested that i take it to
> this mailing list instead.
>
> Commit https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bc1c373dd2a5113800360f7152be729c9da996cc
> introduced a new method of signing modules.
>
> I attempted to make a patch to support this new method of signing. But
> whilst doing so i came to the conclusion that a lot of things that are
> in the appended struct are now set to zero.
> Infact, everything except id_type (which is 2) and sig_len is set to
> zero. Instead this information seems to be embedded in the signature
> blob instead.

That struct should be filled by the tool signing the module:

/*
 * Module signature information block.
 */
struct module_signature {
        uint8_t algo;        /* Public-key crypto algorithm [enum pkey_algo] */
        uint8_t hash;        /* Digest algorithm [enum pkey_hash_algo] */
        uint8_t id_type;     /* Key identifier type [enum pkey_id_type] */
        uint8_t signer_len;  /* Length of signer's name */
        uint8_t key_id_len;  /* Length of key identifier */
        uint8_t __pad[3];
        uint32_t sig_len;    /* Length of signature data (big endian) */
};


I'm not sure why it was decided to omit this information in the commit
you mentioned and embed it inside the signature blob. I'm CC'ing
Michael who worked on the support for signature in kmod and David who
did that commit.  Ideally kmod would not link to any crypto library.


thanks

Lucas De Marchi
