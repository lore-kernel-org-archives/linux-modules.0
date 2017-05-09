MIME-Version: 1.0
In-Reply-To: <xunyshmagsw1.fsf@redhat.com>
References: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
	<xunyshmagsw1.fsf@redhat.com>
Date: Tue, 9 May 2017 00:51:43 -0700
Message-ID: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] depmod: implement external directories support
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Sat, Mar 18, 2017 at 2:46 PM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Hi, Lucas!
>
> Any feedback on that?

I gave it a quick look and it looks good to me. I applied the second patch.

For first patch would be good to use scratchbuf

For this one... I miss some tests in the testsuite to be confident
this a) is working as expected
and b) isn't break the current behavior.


Sorry for the delay.


Lucas De Marchi
