import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import AxiosAPIHelper from '../../heplers/AxiosHelper';
import Loader from '../../constants/Loader';
import NoDataFound from '../../constants/NoDataFound';
import { Form, Button } from 'react-bootstrap';
import CardComponent from '../../Components/card';
import CommonPagination from '../../Components/pagination';

const CompanyLanding = () => {
  const { company_slug } = useParams();
  const [companyPrograms, setCompanyPrograms] = useState('')
  const [companyData, setCompanyData] = useState('')
  const [isLoading, setIsloading] = useState(true)
  const [search, setSearch] = useState(null)
  const [currentPage, setCurrentPage] = useState(1)
  const user = JSON.parse(localStorage.getItem('user'))
  const companySlug = company_slug || user.company_slug
  let itemsPerPage = 10

  useEffect(() => {
    getCompanyData(companySlug)
  }, [companySlug]);

  const getCompanyData = async (companySlug) => {
    setIsloading(true)
    let { response, error, token } = await AxiosAPIHelper({ url: `/api/v1/companies/${companySlug}/landing_page` })
    if (response) {
      setCompanyData(response)
      let company_id = response.id
      if (company_id) {
        await getCompanyProgramData(company_id, 1)
      } else {
        setCompanyData('')
      }
    }
    setIsloading(false)

  }

  const onPageChange = ({ selected }) => {
    getCompanyProgramData('', selected + 1)
    setCurrentPage(selected + 1)
  }

  const getCompanyProgramData = async (companyId, page, searchitem) => {
    let searchData = searchitem || search || null
    let pageNumber = page || currentPage
    let company_id = companyId || companyData.id
    let CompanyProgramsData = await AxiosAPIHelper({ url: `/api/v1/companies/${company_id}/company_programs`, params: { page: pageNumber, per_page: itemsPerPage, search: searchData } })
    if (CompanyProgramsData.response) {
      setCompanyPrograms(CompanyProgramsData.response)
    }
  }

  const handleSearch = () => {
    getCompanyProgramData('', currentPage, search)
  }

  return (
    isLoading ? <Loader />
      : companyData ?
        <div>
          <div className='main-banner position-relative'>
            <img src={companyData.cover_photo} className='cover-img position-absolute h-100 ' />
            <div className='position-absolute d-flex justify-content-left align-items-left gap-5 h-100 w-100 banner-holder'>
              <img src={companyData?.logo} className='logo-img rounded' />
              <h4>{companyData?.heading}</h4>
            </div>
          </div>
          <div className='heading w-75 m-auto my-5 company-desc-box p-2 company-desc-box'>
            <h4>About</h4>
            <p>{companyData?.description}</p>
          </div>
          <div className='w-75 m-auto'>
            <h4 className='mx-3'> Company Programs </h4>
            <div className='mx-3'><hr /></div>

            <div className='search d-flex align-items-center justify-content-left w-75 m-auto gap-3 mx-3 py-1'>
              <Form.Group className='' >
                <Form.Control
                  type="search"
                  placeholder="Search Programs"
                  name="search"
                  className='p-2'
                  onChange={(e) => setSearch(e.target.value)}
                  required
                />
              </Form.Group>
              <Button
                variant="warning"
                size="lg"
                className="btn-login text-uppercase fw-bold"
                onClick={handleSearch}
              >
                Search
              </Button>
            </div>

            {companyPrograms && companyPrograms.company_programs.length > 0 ? (
              <>
                <div className='company-datils row'>
                  {
                    companyPrograms.company_programs.map((item, index) => {
                      return (
                        <div className='col-lg-3 col-md-4 col-sm-6 col-xs-12 my-3' key={item.id}>
                          <CardComponent
                            title={item.name}
                            image={item.cover_image}
                            slug={item.slug}
                            id={item.id}
                            companyId={item.company_id}
                            companySlug={item.company_slug}
                            details=''
                          />
                        </div>
                      )
                    })
                  }
                </div>
                <div className='mx-3 my-3'>
                  <CommonPagination
                    totalPages={Math.ceil(companyPrograms.metadata.total_count / itemsPerPage)}
                    onPageChange={onPageChange}
                  />
                </div>
              </>
            ) : (
              <div className='no-pgoram-data'>
                <NoDataFound />
              </div>
            )}
          </div>

        </div>
        : <NoDataFound />
    // <div>    
    //     {!loadingCompany ? (
    //         <>
    //             {
    //                 company.id ? (
    //                     <div>
    //                        

    //                         {/* <div className='container'>
    //       <div className='logo-container'>
    //       </div>
    //       <div>{company.heading}</div>
    //     </div> */}
    //                     </div>
    //                 ) : (
    //                     <div>No Data Found...</div>
    //                 )
    //             }
    //         </>
    //     ) : (
    //         <div>Loading...</div>
    //     )}

    //     {companyPrograms.length > 0 ? (
    //         <div>{companyPrograms.length}</div>
    //     ) : (
    //         <div>Loading...</div>
    //     )}
    // </div >
  );
}

export default CompanyLanding;