import React, { useState, useEffect } from 'react';
import AxiosAPIHelper from '../../heplers/AxiosHelper';
import Loader from '../../constants/Loader';
import NoDataFound from '../../constants/NoDataFound';
import { Form, Button, Container, Row } from 'react-bootstrap';
import CardComponent from '../../Components/card';
import CommonPagination from '../../Components/pagination';

const CompanyLanding = () => {
  const [companyPrograms, setCompanyPrograms] = useState('')
  const [isLoading, setIsloading] = useState(true)
  const [search, setSearch] = useState('')
  const [currentPage, setCurrentPage] = useState(1)
  let itemsPerPage = 10

  useEffect(() => {
    getCompanyProgramData(1)
  }, []);

  const onPageChange = ({ selected }) => {
    getCompanyProgramData(selected + 1)
    setCurrentPage(selected + 1)
  }

  const getCompanyProgramData = async (page, searchitem) => {
    setIsloading(true)

    let searchData = searchitem || search || null
    let pageNumber = page || currentPage
    let CompanyProgramsData = await AxiosAPIHelper({ url: `/api/v1/dashboard`, params: { page: pageNumber, per_page: itemsPerPage, search: searchData } })
    if (CompanyProgramsData.response) {
      setCompanyPrograms(CompanyProgramsData.response)
      setIsloading(false)
    }
  }

  const handleSearch = (e) => {
    e.preventDefault();
    getCompanyProgramData(currentPage, search)
  }

  return (
        <div className='w-75 m-auto my-5'>
          <h4 className='mx-3'> Company Programs </h4>
          <div className='mx-3'><hr /></div>
          <div className='search d-flex align-items-center justify-content-left w-75 m-auto gap-3 mx-3 py-1'>
            <Form.Group className='' >
              <Form.Control
                type="search"
                placeholder="Search Programs"
                name="search"
                className='p-2'
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                required
              />
            </Form.Group>
            <Button
              variant="warning"
              size="lg"
              type='button'
              className="btn-login text-uppercase fw-bold"
              onClick={handleSearch}
            >
              Search
            </Button>
          </div>

          {isLoading ? (
            <Loader />
          ) : companyPrograms && companyPrograms.company_programs.length > 0 ? (
            <>
              <div className='company-datils row'>
                {
                  companyPrograms.company_programs.map((item, index) => {
                    return (
                      <div className='col col-sm-12 col-md-4 col-lg-3 col-xs-4 my-3' key={item.id}>
                        <CardComponent
                          title={item.name}
                          image={item.cover_image}
                          slug={item.slug}
                          id={item.id}
                          companyId={item.company_id}
                          companyName={item.company_name}
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
  )
}

export default CompanyLanding;